using Newtonsoft.Json.Linq;
using Proyecto_Final_Sistema_Reservaciones.Class;
using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
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
                    DL_Clientes.Items.Add(new ListItem("Selecciona una opción...", "-1"));

                    using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                    {
                        ObjectResult<spGestionar_Reservaciones_ID_Result> Reservaciones = db.spGestionar_Reservaciones_ID(Usu.Id);
                        GVW_Gestionar.DataSource = Reservaciones;
                        GVW_Gestionar.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/Pages/Error.aspx");
                }
            }
           
        }

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

        protected void Button1_Click(object sender, EventArgs e)
        {
          
            try
            {

                DateTime Fecha_Entrada = Convert.ToDateTime(TXT_Fecha_En.Text);
                DateTime Fecha_Salida = Convert.ToDateTime(TXT_Fecha_Sal.Text);
                string Nombre =DL_Clientes.SelectedItem.Text;
                using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                {
                    ObjectResult<spFiltro_Gestionar_Reservaciones_Result> Filtro =  db.spFiltro_Gestionar_Reservaciones(Nombre,Fecha_Entrada,Fecha_Salida);
                    GVW_Gestionar.DataSource = Filtro;
                    GVW_Gestionar.DataBind();

                }

            }
            catch (Exception)
            {
                Response.Redirect("~/Pages/Error.aspx");
            }
           
        }

        protected void DL_Clientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DL_Clientes.SelectedValue != "-1")
            {
                var lista = new List<ListItem>();
                using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                {
                    lista = db.spConsultar_Usuarios().Select(_ => new ListItem { Text = _.nombreCompleto, Value = _.idPersona.ToString() }).ToList();
                }

                DL_Clientes.DataSource = lista;
                DL_Clientes.DataBind();
            }
               
        }
    }
}