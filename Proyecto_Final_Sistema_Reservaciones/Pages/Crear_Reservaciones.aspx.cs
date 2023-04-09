using Proyecto_Final_Sistema_Reservaciones.Class;
using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Crear_Reservaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuarios Usu = (Usuarios)Session["Usuario_Res"];
            if (Usu == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
            }
            if (Page.IsPostBack == false)
            {
                try
                {
                    using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                    {
                        if (Usu.Rol == true)
                        {
                            var lista_Clientes = new List<ListItem>();
                            lista_Clientes = db.spConsultar_Usuarios().Select(_ => new ListItem { Text = _.nombreCompleto, Value = _.idPersona.ToString() }).ToList();
                            ListItem primer_elemento = new ListItem("Seleccione un cliente", "");
                            lista_Clientes.Insert(0, primer_elemento);
                            DL_Cliente.DataSource = lista_Clientes;
                            DL_Cliente.DataBind();
                        }
                        else
                        {
                            var lista_Clientes = new List<ListItem>();
                            ListItem primer_elemento_Personas = new ListItem(Usu.Nombre_Completo, Convert.ToString(Usu.Id));
                            lista_Clientes.Insert(0, primer_elemento_Personas);
                            DL_Cliente.DataSource = lista_Clientes;
                            DL_Cliente.DataBind();
                        }
                        var lista_Hoteles = new List<ListItem>();
                        lista_Hoteles = db.spConsultar_Hoteles().Select(_ => new ListItem { Text = _.nombre, Value = _.idHotel.ToString() }).ToList();
                        ListItem primer_elemento_Hoteles = new ListItem("Seleccione un hotel", "");
                        lista_Hoteles.Insert(0, primer_elemento_Hoteles);
                        DL_Hotel.DataSource=lista_Hoteles;
                        DL_Hotel.DataBind();
                    }
                    
                }
                catch (Exception)
                {

                    throw;
                }
                INP_Num_A.Value = Convert.ToString(1);
                INP_Num_N.Value = Convert.ToString(0);
            }
        }

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid == true)
            {

            }

        }

        

        protected void CV_Fecha_Sal_ServerValidate(object source, ServerValidateEventArgs args)
        {
            
            DateTime fecha;
            if (DateTime.TryParseExact(args.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha))
            {
                DateTime fecha_en;
                if (DateTime.TryParseExact(INP_Fecha_En.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha_en))
                {
                    if (fecha <= DateTime.Now)
                    {
                        if (fecha_en > fecha)
                        {
                            args.IsValid = false;
                            CV_Fecha_Sal.ErrorMessage = "La fecha de salida debe de ser mayor a la fecha entrada.";
                        }
                        else
                        {
                            args.IsValid = true;
                        }
                    }
                    else
                    {
                        args.IsValid = false;
                        CV_Fecha_En.ErrorMessage = "La fecha de entrada debe ser menor que la fecha actual.";
                    }
                }
                else
                {
                    args.IsValid = false;
                    CV_Fecha_En.ErrorMessage = "El formato de la fecha entrada es inválido.";
                }

            }
            else
            {
                args.IsValid = false;
                CV_Fecha_Sal.ErrorMessage = "El formato de la fecha de salida es inválido.";
            }
        }

        protected void CV_Fecha_En_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;
            if (DateTime.TryParseExact(args.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha))
            {
                if (fecha <= DateTime.Now)
                {
                    
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                    CV_Fecha_En.ErrorMessage = "La fecha de entrada debe ser menor que la fecha actual.";
                }
            }
            else
            {
                args.IsValid = false;
                CV_Fecha_En.ErrorMessage = "El formato de la fecha entrada es inválido.";
            }
        }
    }
}