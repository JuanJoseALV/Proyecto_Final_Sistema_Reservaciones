using Proyecto_Final_Sistema_Reservaciones.Class;
using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Modificar_Reservacion : System.Web.UI.Page
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
                int idReservacion = Convert.ToInt32(Request.QueryString["idReservacion1"]);
                using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                {
                    if (Usu.Rol == true)
                    {
                        List<spConsultar_Reservaciones_ID_Result> Reservaciones = db.spConsultar_Reservaciones_ID(idReservacion).ToList();
                        foreach (spConsultar_Reservaciones_ID_Result reserva in Reservaciones)
                        {
                            TXT_Cliente.Value = reserva.nombreCompleto;
                            TXT_Hotel.Value = reserva.nombre;
                            TXT_Numero_Hotel.Value = reserva.numeroHabitacion;

                            INP_Fecha_En.Value = Convert.ToString(reserva.fechaEntrada.ToString("dd/MM/yyyy"));
                            INP_Fecha_Sal.Value = Convert.ToString(reserva.fechaSalida.ToString("dd/MM/yyyy"));
                            INP_Num_A.Value = Convert.ToString(reserva.numeroAdultos);
                            INP_Num_N.Value = Convert.ToString(reserva.numeroNinhos);
                            if (reserva.fechaEntrada <= DateTime.Now)
                            {
                                INP_Fecha_En.Disabled = true;
                            }

                        }
                    }
                    else
                    {
                        spValidar_Reservaciones_Persona_Result Reservaciones1 = db.spValidar_Reservaciones_Persona(idReservacion, Usu.Nombre_Completo).FirstOrDefault();
                        if (Reservaciones1 == null)
                        {
                            Response.Redirect("~/Pages/Mis_Reservaciones.aspx", false);
                        }
                        else
                        {
                            List<spConsultar_Reservaciones_ID_Result> Reservaciones = db.spConsultar_Reservaciones_ID(idReservacion).ToList();
                            foreach (spConsultar_Reservaciones_ID_Result reserva in Reservaciones)
                            {
                                TXT_Cliente.Value = reserva.nombreCompleto;
                                TXT_Hotel.Value = reserva.nombre;
                                TXT_Numero_Hotel.Value = reserva.numeroHabitacion;

                                INP_Fecha_En.Value = Convert.ToString(reserva.fechaEntrada.ToString("dd/MM/yyyy"));
                                INP_Fecha_Sal.Value = Convert.ToString(reserva.fechaSalida.ToString("dd/MM/yyyy"));
                                INP_Num_A.Value = Convert.ToString(reserva.numeroAdultos);
                                INP_Num_N.Value = Convert.ToString(reserva.numeroNinhos);
                                if (reserva.fechaEntrada <= DateTime.Now)
                                {
                                    INP_Fecha_En.Disabled = true;
                                }

                            }
                        }
                    }

                       
                       
                    

                }
                INP_Num_A.Value = Convert.ToString(1);
                INP_Num_N.Value = Convert.ToString(0);
            }
            

        }
        
        

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            int idReservacion = Convert.ToInt32(Request.QueryString["idReservacion1"]);
            bool Hotel = false;
            if (Page.IsValid == true)
            {
                try
                {

                    DateTime fechaEntrada = Convert.ToDateTime(INP_Fecha_En.Value);
                    DateTime fechaSalida = Convert.ToDateTime(INP_Fecha_Sal.Value);
                    int numeroAdultos = Convert.ToInt32(INP_Num_A.Value);
                    int numeroNinhos = Convert.ToInt32(INP_Num_N.Value);
                    int totalDiasReservacion = (fechaSalida - fechaEntrada).Days;
                    DateTime fechaModificacion = DateTime.Now;
                    int numPersonas = numeroAdultos + numeroNinhos;

                    decimal costoPorCadaAdulto = 0;
                    decimal costoPorCadaNinho = 0;
                    decimal costoTotal = 0;

                    using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                    {
                        string nombre_hotel = "";

                        List<spConsultar_Reservaciones_ID_Result> Reservaciones = db.spConsultar_Reservaciones_ID(idReservacion).ToList();

                        foreach (spConsultar_Reservaciones_ID_Result reserva in Reservaciones)
                        {
                            nombre_hotel = reserva.nombre;
                        }

                        var lista_Hoteles = new List<ListItem>();
                        lista_Hoteles = db.spConsultar_Hoteles().Where(h => h.nombre == nombre_hotel).Select(h => new ListItem { Value = h.idHotel.ToString() }).ToList();
                        spValidar_Habitaciones_Result Habi = db.spValidar_Habitaciones(Convert.ToInt32(string.Join(",", lista_Hoteles)), numPersonas).FirstOrDefault();
                        if (Habi != null)
                        {
                            spConsultar_Hoteles_Id_Result reserva = db.spConsultar_Hoteles_Id(Convert.ToInt32(string.Join(",", lista_Hoteles))).FirstOrDefault();
                            if (reserva != null)
                            {
                                costoPorCadaAdulto = reserva.costoPorCadaAdulto;
                                costoPorCadaNinho = reserva.costoPorCadaNinho;
                                costoTotal = (costoPorCadaAdulto * numeroAdultos) + (costoPorCadaNinho * numeroNinhos);
                                db.spEditar_Reservacion(idReservacion, fechaEntrada, fechaSalida, numeroAdultos, numeroNinhos, totalDiasReservacion, costoTotal, fechaModificacion);
                                Hotel = true;
                            }
                        }
                        else
                        {
                            LBL_Vali_Habi.Visible = true;
                        }


                    }
                    if (Hotel == true)
                    {
                        using (PV_ProyectoFinalEntities db1 = new PV_ProyectoFinalEntities())
                        {
                            Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                            db1.spCrear_Bitacora(idReservacion, Usu.Id, "CORREGIDA", fechaModificacion);
                            Response.Redirect("~/Pages/Afirmaciones/Afirmacion_Modi.aspx", false);
                        }

                    }
                }
                catch (Exception)
                {

                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }


            }
        }
        protected void CV_Fecha_En_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;
            if (DateTime.TryParseExact(args.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha))
            {
                if (fecha >= DateTime.Now)
                {

                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                    CV_Fecha_En.ErrorMessage = "La fecha de entrada no debe ser menor que la fecha actual.";
                }
            }
            else
            {
                args.IsValid = false;
                CV_Fecha_En.ErrorMessage = "El formato de la fecha entrada es inválido.";
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
                    if (fecha >= DateTime.Now)
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

        protected void BTN_Regresar_Click(object sender, EventArgs e)
        {
            Usuarios Usu = (Usuarios)Session["Usuario_Res"];
            if (Usu.Rol == true)
            {
                Response.Redirect("~/Pages/Gestionar_Reservaciones.aspx");
            }
            else
            {
                Response.Redirect("~/Pages/Mis_Reservaciones.aspx");
            }

        }
    }
}