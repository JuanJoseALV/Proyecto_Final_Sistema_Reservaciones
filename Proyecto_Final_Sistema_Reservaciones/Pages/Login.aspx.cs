using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Mis_Reservaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Sesion_Click(object sender, EventArgs e)
        {
            try
            {

                string email = Txt_Email.Text;
                string clave = Txt_Contraseña.Text;
                using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                {
                    spConsultar_Usuarios_Result provincia = db.spConsultar_Usuarios(email, clave).FirstOrDefault();
                    if (provincia != null)
                    {
                        Response.Redirect("~/Pages/Mis_reservaciones.aspx", false);
                    }
                    else
                    {
                        Label1.Visible = true;
                    }

                }

            }
            catch (Exception)
            {
                Response.Redirect("~/Pages/Error.aspx");
            }
        }
    }
}