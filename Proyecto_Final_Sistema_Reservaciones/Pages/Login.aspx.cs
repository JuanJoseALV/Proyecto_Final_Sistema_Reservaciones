using Proyecto_Final_Sistema_Reservaciones.Class;
using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Mis_Reservaciones : System.Web.UI.Page
    {
        String Juan = "PV_ProyectoFinalEntities";
        String Wes = "PV_ProyectoFinalEntities1";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Btn_Sesion_Click(object sender, EventArgs e)
        {
            bool error = true;
            if (Page.IsValid)
            {
                try
                {

                    string email = Txt_Email.Text;
                    string clave = Txt_Contraseña.Text;
                    using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                    {
                        spLogin_Result Usuario = db.spLogin(email, clave).FirstOrDefault();
                        if (Usuario != null)
                        {
                            Usuarios Usu = new Usuarios();
                            Usu.Nombre_Completo = Usuario.nombreCompleto;
                            Usu.Id = Usuario.idPersona;
                            Usu.Rol = Usuario.esEmpleado;
                            Session["Usuario_Res"] = Usu;
                            error = false;
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

            if (!error)
            {
                Response.Redirect("~/Pages/Mis_Reservaciones.aspx", false);
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;

            Regex regex = new Regex(@"^\w+([\.-]?\w+)*@\bhotmail\.com\b$");
            if (regex.IsMatch(email))
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