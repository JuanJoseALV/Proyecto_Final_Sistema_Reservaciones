using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Mis_Reservaciones1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                {
                    ObjectResult<spConsultar_Reservaciones_Result> Reservaciones = db.spConsultar_Reservaciones(1);
                    GVW_Reservaciones.DataSource = Reservaciones;
                    GVW_Reservaciones.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Pages/Error.aspx");
            }
        }

         
        

        protected void GVW_Reservaciones_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string estado = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "estado"));
                DateTime Fecha_Estrada = Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "fechaEntrada"));
                DateTime Fecha_Actual = DateTime.Now;
                if (estado == "I")
                {
                    e.Row.Cells[5].Text = "Cancelada";
                }
                else if (estado == "A")
                {
                    if (Fecha_Estrada < Fecha_Actual)
                    {
                        e.Row.Cells[5].Text = "Finalizada";
                    }
                    else if (Fecha_Estrada <= Fecha_Actual)
                    {
                        e.Row.Cells[5].Text = "En proceso";
                    }
                    else if (Fecha_Estrada >= Fecha_Actual)
                    {
                        e.Row.Cells[5].Text = "En espera";
                    }
                }
               
            }
        }
    }
}