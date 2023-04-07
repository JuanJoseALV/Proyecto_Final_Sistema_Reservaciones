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
            try
            {
                Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                using (PV_ProyectoFinalEntities1 db = new PV_ProyectoFinalEntities1())
                {
                    ObjectResult<spGestionar_Reservaciones_Result> Reservaciones = db.spGestionar_Reservaciones(Usu.Id);
                    GVW_Gestionar.DataSource = Reservaciones;
                    GVW_Gestionar.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Pages/Error.aspx");
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
    }
}