using Proyecto_Final_Sistema_Reservaciones.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["Usuario_Res"] != null)
            {
                LBTN_Cerrar_Sesion.Visible=true;
                Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                Nombre.InnerText = Usu.Nombre_Completo;
                Mis_Res.Visible = true;
                if (Usu.Rol == true)
                {
                    Gestionar_habitaciones.Visible=true;
                    Gestionar_R.Visible = true;
                }
            }
        }

        protected void LBTN_Cerrar_Sesion_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("~/Pages/Login.aspx");
            Nombre.InnerText = string.Empty;
        }
    }
}