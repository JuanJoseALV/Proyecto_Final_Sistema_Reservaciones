using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Detalle_Reservacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario_Res"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
            }
            try
            {
                if (IsPostBack == false)
                {
                    int idReservacion = Convert.ToInt32(Request.QueryString["idReservacion"]);
                    using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                    {
                        ObjectResult<spConsultar_Reservaciones_ID_Result> Reservaciones = db.spConsultar_Reservaciones_ID(idReservacion);
                        GridView1.DataSource = Reservaciones;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception)
            {
                Response.Redirect("~/Pages/Error.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Mis_Reservaciones.aspx");
        }
    }
}