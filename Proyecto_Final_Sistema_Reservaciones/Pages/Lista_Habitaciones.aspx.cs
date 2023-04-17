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
    public partial class LIsta_Habitaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario_Res"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
            }
            try
            {
                Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                {
                    ObjectResult<spConsultar_Habitaciones_Result> Reservaciones = db.spConsultar_Habitaciones();
                    GVW_Habitaciones.DataSource = Reservaciones;
                    GVW_Habitaciones.DataBind();


                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Pages/Errores/Error.aspx");
            }
        }

        protected void GVW_Habitaciones_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string estado = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "estado"));

                if (estado == "I")
                {
                    e.Row.Cells[4].Text = "Inactiva";
                }
                else if (estado == "A")
                {
                    e.Row.Cells[4].Text = "Activa";
                }
            }
        }
    }
}