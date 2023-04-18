using Microsoft.Ajax.Utilities;
using Proyecto_Final_Sistema_Reservaciones.Class;
using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Crear_Habitaciones : System.Web.UI.Page
    {
        /*Esta función se ejecuta cuando se carga la página web. Comienza verificando si un usuario ha iniciado sesión y, si no, 
          redirige al usuario a la página de inicio de sesión. Luego, si la página no se está cargando debido a un evento de "PostBack",
          consulta una base de datos para obtener una lista de hoteles y los agrega a un control de lista desplegable en la página.
          Finalmente, establece el valor máximo permitido de una entrada de usuario en "1".*/

        protected void Page_Load(object sender, EventArgs e)
        {
            // Este proceso verifica si el usuario ya inicio sesion de lo contrario lo envia a la pagina de login

            Usuarios Usu = (Usuarios)Session["Usuario_Res"];
            if (Usu == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
            }
            if (Page.IsPostBack == false)
            {
                try
                {
                    // Este proceso carga la lista de hoteles al dropdown de DL_Habitacion

                    using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
                    {
                        var lista_Hoteles = new List<ListItem>();
                        lista_Hoteles = db.spConsultar_Hoteles().Select(_ => new ListItem { Text = _.nombre, Value = _.idHotel.ToString() }).ToList();
                        ListItem primer_elemento_Hoteles = new ListItem("Seleccione un hotel", "");
                        lista_Hoteles.Insert(0, primer_elemento_Hoteles);
                        DL_Hotel.DataSource = lista_Hoteles;
                        DL_Hotel.DataBind();
                    }

                }
                catch (Exception)
                {

                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }

                // Ingresa el valor inicial al input de cantidad maxima de personas por habitacion

                INP_Cantidad_Max.Value = Convert.ToString(1);
            }
        }

        /*Esta función se ejecuta cuando el usuario hace clic en el botón "Guardar". Primero, comprueba si la validación de la página es
          correcta. Si es así, recupera los valores de algunos controles de la página web, como el hotel seleccionado y el número de
          habitación. Luego, verifica si una habitación con el mismo número ya existe en la base de datos para ese hotel y muestra un
          mensaje de error si es así. Si no existe, crea una nueva entrada en la base de datos para la habitación y redirige al usuario
          a una página de afirmación.*/

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            bool Hotel = false;
            if (Page.IsValid == true)
            {
                try
                {
                    // Este proceso carga toda la informacion necesaria para hacer la insercion en la base de datos 

                    string idHotel = DL_Hotel.SelectedItem.Value;
                    string Numero_Habi = INP_Numero_Habi.Value;
                    int Cantidad_Max = Convert.ToInt32(INP_Cantidad_Max.Value);
                    string Descripcion = INP_Descripcion.Value;
                    string estado = "A";

                    // Este if valida que se haya escogido un hotel y no se haya dejado el texto inicial del dropDown

                    if (string.IsNullOrEmpty(idHotel)==false)
                    {
                        int idHotel1 = Convert.ToInt32(DL_Hotel.SelectedItem.Value);
                        using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
                        {

                            /* Este proceso valida por medio de una comsulta en la base de datos que no exista una habitacion dentro del hotel*
                               con el mismo numero de habitacion */

                            var lista_Habitaciones = new List<ListItem>();
                            lista_Habitaciones = db.spConsultar_Habitaciones().Where(h => h.numeroHabitacion == Numero_Habi && h.idHotel == idHotel1).Select(h => new ListItem { Value = h.idHabitacion.ToString() }).ToList();
                            if (lista_Habitaciones.Count == 0 )
                            {
                                Hotel = true;
                            }
                            else
                            {
                                LBL_Vali_Habi.Visible = true;
                            }


                        }
                        // Este proceso es el de insercion en la base de datos se ejecuta unicamente si el proceso anterior se cumple sastifactoriamente 
                        if (Hotel == true)
                        {
                            using (PV_ProyectoFinalEntities2 db1 = new PV_ProyectoFinalEntities2())
                            {
                                db1.spCrear_Habitacion(idHotel1, Numero_Habi, Cantidad_Max, Descripcion, estado);
                                Response.Redirect("~/Pages/Afirmaciones/Afirmacion_Crear_Habi.aspx",false);
                            }
                        }
                    }
                    else
                    {
                        LBl_Validacion_Ho.Visible = true;
                    }
                    


                }
                catch (Exception)
                {

                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }


            }
        }
        // Este procerso unicamente hace una redireccion a la pagina de lista de habitaciones 
        protected void BTN_Regresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Lista_Habitaciones.aspx");
        }
    }
}