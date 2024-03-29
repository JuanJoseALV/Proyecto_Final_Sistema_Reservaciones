﻿using Proyecto_Final_Sistema_Reservaciones.Class;
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
        String Juan = "PV_ProyectoFinalEntities";
        String Wes = "PV_ProyectoFinalEntities1";

        /* El código verifica si el usuario ha iniciado sesión y lo redirige a la página de inicio de sesión si no lo está. Luego recupera
           las reservas del usuario de la base de datos mediante un procedimiento almacenado */

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
                    ObjectResult<spConsultar_Mis_Reservaciones_Result> Reservaciones = db.spConsultar_Mis_Reservaciones(Usu.Id);
                    GVW_Reservaciones.DataSource = Reservaciones;
                    GVW_Reservaciones.DataBind();
                    

                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Pages/Errores/Error.aspx");
            }
        }

        /*El código comprueba el estado de cada reserva y muestra el mensaje de estado correspondiente en el control GridView. Si se
          cancela la reserva, muestra "Cancelada". Si la reserva está activa, comprueba las fechas de la reserva y muestra "Finalizada"
          si la fecha de finalización es pasada, "En proceso" si la fecha de inicio es pasada o "En espera" si la fecha de inicio es pasada.
          en el futuro.*/

        protected void GVW_Reservaciones_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string estado = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "estado"));
                DateTime Fecha_Entrada = Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "fechaEntrada"));
                DateTime Fecha_Salida = Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "fechaSalida"));
                DateTime Fecha_Actual = DateTime.Now;
                if (estado == "I")
                {
                    e.Row.Cells[5].Text = "Cancelada";
                }
                else if (estado == "A")
                {
                    if (Fecha_Salida < Fecha_Actual)
                    {
                        e.Row.Cells[5].Text = "Finalizada";
                    }
                    else if (Fecha_Entrada <= Fecha_Actual)
                    {
                        e.Row.Cells[5].Text = "En proceso";
                    }
                    else if (Fecha_Entrada >= Fecha_Actual)
                    {
                        e.Row.Cells[5].Text = "En espera";
                    }
                }
               
            }
        }

        
        
    }
}