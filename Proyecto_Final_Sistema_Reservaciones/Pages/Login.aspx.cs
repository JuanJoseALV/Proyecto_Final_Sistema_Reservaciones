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

        /*Se activa cuando el usuario hace clic en el botón de inicio de sesión. Primero verifica si la página es válida usando la
          Page.IsValidpropiedad. Si es válido, intenta autenticar al usuario consultando la base de datos con el correo electrónico y
          la contraseña proporcionados. Si se encuentra un usuario, Usuariosse crea e inicializa un objeto con el nombre, la identificación
          y la función del usuario, y el objeto se guarda en una variable de sesión denominada "Usuario_Res". Si no se encuentra ningún usuario
          , se muestra un mensaje de error en la página.*/

        protected void Btn_Sesion_Click(object sender, EventArgs e)
        {
            bool error = true;
            if (Page.IsValid)
            {
                try
                {

                    string email = Txt_Email.Text;
                    string clave = Txt_Contraseña.Text;
                    using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
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
                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }
            }

            if (!error)
            {
                Response.Redirect("~/Pages/Mis_Reservaciones.aspx", false);
            }
        }

        /*Método es un método de validación del lado del servidor para el campo de entrada de correo electrónico. Utiliza una expresión regular
          para validar que la dirección de correo electrónico es una dirección de hotmail.*/

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