using Newtonsoft.Json.Linq;
using Proyecto_Final_Sistema_Reservaciones.Class;
using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Gestionar_Reservaciones : System.Web.UI.Page
    {

        String Juan = "PV_ProyectoFinalEntities";
        String Wes = "PV_ProyectoFinalEntities1";

        /*Este método se llama cuando se carga la página. Primero verifica si la variable de sesión "Usuario_Res" es nula y redirige al
          usuario a la página de inicio de sesión si lo es. A continuación, rellena un control DropDownList con una lista de usuarios
          recuperada de una base de datos mediante un procedimiento almacenado. Finalmente, recupera una lista de reservas asociadas con el
          usuario conectado actualmente y las vincula a un control GridView.*/

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario_Res"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
            }
            if (Page.IsPostBack == false)
            {
                try
                {
                    Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                    var lista = new List<ListItem>();
                    
                    using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
                    {
                        lista = db.spConsultar_Usuarios().Select(_ => new ListItem { Text = _.nombreCompleto, Value = _.idPersona.ToString() }).ToList();
                    }
                    ListItem primer_elemento = new ListItem("Seleccione un cliente ", "");
                    lista.Insert(0, primer_elemento);
                    DL_Clientes.DataSource = lista;
                    DL_Clientes.DataBind();

                    using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
                    {
                        ObjectResult<spGestionar_Reservaciones_ID_Result> Reservaciones = db.spGestionar_Reservaciones_ID(Usu.Id);
                        GVW_Gestionar.DataSource = Reservaciones;
                        GVW_Gestionar.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }
            }
           
        }

        /*Este método se llama para cada fila del control GridView. Comprueba el estado de la reserva (es decir, si está cancelada, en proceso
          o finalizada) y muestra el texto correspondiente en la columna "estado".*/

        protected void GVW_Gestionar_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string estado = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "estado"));
                DateTime Fecha_Estrada = Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "fechaEntrada"));
                DateTime Fecha_Actual = DateTime.Now;
                if (estado == "I")
                {
                    e.Row.Cells[6].Text = "Cancelada";
                }
                else if (estado == "A")
                {
                    if (Fecha_Estrada < Fecha_Actual)
                    {
                        e.Row.Cells[6].Text = "Finalizada";
                    }
                    else if (Fecha_Estrada <= Fecha_Actual)
                    {
                        e.Row.Cells[6].Text = "En proceso";
                    }
                    else if (Fecha_Estrada >= Fecha_Actual)
                    {
                        e.Row.Cells[6].Text = "En espera";
                    }
                }

            }
        }

        /*Este método se llama cuando el usuario hace clic en un botón para filtrar la lista de reservas por cliente y rango de fechas.
          Recupera el cliente seleccionado y el intervalo de fechas de la interfaz de usuario, llama a un procedimiento almacenado para 
          recuperar una lista filtrada de reservas de la base de datos y las vincula al control GridView.*/
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {

                    DateTime Fecha_Entrada = Convert.ToDateTime(INP_Fecha_Entrada.Value);
                    DateTime Fecha_Salida = Convert.ToDateTime(INP_Fecha_Salida.Value);
                    string Nombre = DL_Clientes.SelectedItem.Text;
                    using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
                    {
                        ObjectResult<spFiltro_Gestionar_Reservaciones_Result> Filtro = db.spFiltro_Gestionar_Reservaciones(Nombre, Fecha_Entrada, Fecha_Salida);
                        GVW_Gestionar.DataSource = Filtro;
                        GVW_Gestionar.DataBind();

                    }

                }
                catch (Exception)
                {
                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }
            }
           
           
        }

        /*CustomValidator2_ServerValidate y CustomValidator1_ServerValidate: estos métodos son métodos de validación personalizados
          para las entradas de fecha. Verifican si la entrada de fecha está en el formato correcto (dd/MM/aaaa) y configuran la propiedad
          IsValid del control de validación en consecuencia.*/

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;
            if (DateTime.TryParseExact(args.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;
            if (DateTime.TryParseExact(args.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }
    }
}