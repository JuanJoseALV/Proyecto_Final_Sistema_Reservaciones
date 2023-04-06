using Proyecto_Final_Sistema_Reservaciones.Class;
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
            Usuarios Usu = (Usuarios)Session["Usuario_Res"];
            if (Usu == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
            }

            int idReservacion = Convert.ToInt32(Request.QueryString["idReservacion"]);

            try
            {
                using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                {
                    if (Usu.Rol == true)
                    {
                        ObjectResult<spConsultar_Reservaciones_ID_Result> Reservaciones = db.spConsultar_Reservaciones_ID(idReservacion);
                        dtl_Detalle.DataSource = Reservaciones;
                        dtl_Detalle.DataBind();
                    }
                    else
                    {
                        spConsultar_Reservaciones_ID_Persona_Result Reservaciones = db.spConsultar_Reservaciones_ID_Persona(idReservacion, Usu.Nombre_Completo).FirstOrDefault();
                        if (Reservaciones == null)
                        {
                            Response.Redirect("~/Pages/Mis_Reservaciones.aspx", false);
                        }
                        else
                        {
                            ObjectResult<spConsultar_Reservaciones_ID_Result> Reservaciones1 = db.spConsultar_Reservaciones_ID(idReservacion);
                            dtl_Detalle.DataSource = Reservaciones1;
                            dtl_Detalle.DataBind();
                        }
                    }

                    ObjectResult<spConsultar_Bitacora_Result> bitacora = db.spConsultar_Bitacora(idReservacion);
                    GV_Bit.DataSource = bitacora;
                    GV_Bit.DataBind();
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
        protected int GetReservationDays(string fechaEntradaStr, string fechaSalidaStr)
        {
            DateTime fechaEntrada = DateTime.Parse(fechaEntradaStr);
            DateTime fechaSalida = DateTime.Parse(fechaSalidaStr);
            int dias = (fechaSalida - fechaEntrada).Days;

            if (dias == 0)
            {
                return 1;
            }
            else
            {
                return dias + 1;
            }
        }
        public string GetReservationCost(double costo)
        {
            string formattedCost = string.Format("${0:#,0.00}", costo);

            return formattedCost;
        }
    }
}