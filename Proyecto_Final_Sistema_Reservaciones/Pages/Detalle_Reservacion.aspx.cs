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
        
        String Juan = "PV_ProyectoFinalEntities";
        String Wes = "PV_ProyectoFinalEntities1";

        DateTime Fecha_Compu = DateTime.Now;

        /*Comprueba si la página se está cargando por primera vez o si se está cargando en respuesta a una devolución de datos.
          Si es la primera vez, comprueba si el usuario ha iniciado sesión y, si no lo está, lo redirige a la página de inicio de sesión.
          Luego recupera el ID de la reserva de la cadena de consulta y consulta la base de datos para obtener información sobre la reserva.
          Según el rol del usuario (administrador o cliente), muestra diferentes botones para editar o cancelar la reserva. También recupera y
          muestra la bitácora (historial de cambios) de la reserva.*/
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == false)
            {
                // Este proceso verifica si el usuario ya inicio sesion de lo contrario lo envia a la pagina de login

                Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                if (Usu == null)
                {
                    Response.Redirect("~/Pages/Login.aspx");
                }

                //Toma el id enviado por el link
                
                int idReservacion = Convert.ToInt32(Request.QueryString["idReservacion"]);

                try
                {
                    using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
                    {
                        /* Valida si es un empleado o no, si lo es se le permite modificar el link y buscar cualquier otra reservacion*/
                        if (Usu.Rol == true)
                        {
                            // Toma el registro de la reservacion enviada por el link 

                            List<spConsultar_Reservaciones_ID_Result> Reservaciones = db.spConsultar_Reservaciones_ID(idReservacion).ToList();
                            foreach (spConsultar_Reservaciones_ID_Result reserva in Reservaciones)
                            {
                                string estado = reserva.estado;
                                DateTime fechaSalida = reserva.fechaSalida;
                                DateTime fechaEntrada = reserva.fechaEntrada;
                                
                                // Valida que botones se pueden mostar y cuales no 

                                if (estado == "A" && Fecha_Compu < fechaSalida)
                                {
                                    BTN_Editar.Visible = true;
                                }
                                if (estado == "A" && Fecha_Compu < fechaEntrada)
                                {
                                    BTN_Cancelar.Visible = true;

                                }

                                dtl_Detalle.DataSource = Reservaciones;
                                dtl_Detalle.DataBind();
                            }
                        }
                        else
                        {
                            /* Valida por medio de un procedimiento que recibe el nombre del usuario y el id de la reservacion y si
                               no le pertenese lo devuelve a la pagina de mis reservaciones */

                            spValidar_Reservaciones_Persona_Result Reservaciones = db.spValidar_Reservaciones_Persona(idReservacion, Usu.Nombre_Completo).FirstOrDefault();
                            if (Reservaciones == null)
                            {
                                Response.Redirect("~/Pages/Mis_Reservaciones.aspx", false);
                            }
                            else
                            {
                                // Toma el registro de la reservacion enviada por el link

                                List<spConsultar_Reservaciones_ID_Result> Reservaciones1 = db.spConsultar_Reservaciones_ID(idReservacion).ToList();
                                foreach (spConsultar_Reservaciones_ID_Result reserva in Reservaciones1)
                                {
                                    string estado = reserva.estado;
                                    DateTime fechaSalida = reserva.fechaSalida;
                                    DateTime fechaEntrada = reserva.fechaEntrada;

                                    // Valida que botones se pueden mostar y cuales no 

                                    if (estado == "A" && Fecha_Compu < fechaEntrada)
                                    {
                                        BTN_Editar.Visible = true;
                                        BTN_Cancelar.Visible = true;
                                    }
                                    dtl_Detalle.DataSource = Reservaciones1;
                                    dtl_Detalle.DataBind();
                                }
                            }
                        }

                        // Toma el historial de la bitacora de esa reservacion 
                        
                        ObjectResult<spConsultar_Bitacora_Result> bitacora = db.spConsultar_Bitacora(idReservacion);
                        GV_Bit.DataSource = bitacora;
                        GV_Bit.DataBind();
                    }
                }
                catch (Exception)
                {
                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }
            }
            

        }

        /*El método se llama cuando el usuario hace clic en el botón "Volver". Redirige al usuario a la página anterior según
          su función (administrador o cliente).*/

        protected void Button1_Click(object sender, EventArgs e)
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

        /*El método calcula el número de días entre la fecha de inicio y finalización de una reserva.*/

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

        /*El método formatea el costo de una reserva como una cadena con un signo de dólar y dos decimales.*/

        public string GetReservationCost(double costo)
        {
            string formattedCost = string.Format("${0:#,0.00}", costo);

            return formattedCost;
        }

        /*método se llama cuando el usuario hace clic en el botón "Editar". Recupera el ID de la reserva de la cadena de consulta y
         redirige al usuario a la página de edición de la reserva.*/

        protected void BTN_Editar_Click(object sender, EventArgs e)
        {
            

            Button btn = (Button)sender;
            
            // Aqui toma el id de la reservacion y la invia por medio de un link

            int idReservacion = Convert.ToInt32(Request.QueryString["idReservacion"]);
            Response.Redirect("~/Pages/Modificar_Reservacion.aspx?idReservacion1=" + idReservacion);
        }

        /*El método se llama cuando el usuario hace clic en el botón "Cancelar". Recupera el ID de la reserva de la cadena de consulta
          y establece el estado de la reserva en "I" (inactivo) en la base de datos, cancelando efectivamente la reserva. Si la reserva
         no se puede cancelar (porque ya está cancelada o ha pasado la fecha de salida), redirige al usuario a la página anterior. Luego
         crea un nuevo registro en la bitácora de la reserva con la información de cancelación.*/

        protected void BTN_Cancelar_Click(object sender, EventArgs e)
        { 
            // Se inicializan las variables a trabajar 
            string estado = "";
            DateTime fechaSalida;
            DateTime fechaEntrada;
            DateTime fecha_actual = DateTime.Now;
            bool Continuar = false;
            Usuarios Usu = (Usuarios)Session["Usuario_Res"];
            int idReservacion = Convert.ToInt32(Request.QueryString["idReservacion"]);
            using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
            {
                // Se toman los datos por medio de un procedimiento que consulta la reservacion a eliminar

                List<spConsultar_Reservaciones_ID_Result> Reservaciones = db.spConsultar_Reservaciones_ID(idReservacion).ToList();
                foreach (spConsultar_Reservaciones_ID_Result reserva in Reservaciones)
                { 
                    estado = reserva.estado;
                    fechaSalida = reserva.fechaSalida;
                    fechaEntrada = reserva.fechaEntrada;

                    // Hace las validaciones correspondientes para poder eliminar la reservacion 

                    if (estado == "I" || fechaSalida <= DateTime.Now || fechaEntrada <= DateTime.Now || fechaSalida > DateTime.Now && fechaEntrada < DateTime.Now)
                    {
                        
                        if (Usu.Rol == true)
                        {
                            Response.Redirect("~/Pages/Gestionar_Reservaciones.aspx");
                        }
                        else
                        {
                            Response.Redirect("~/Pages/Mis_Reservaciones.aspx");
                        }
                    }
                    else
                    {
                        // Este procedimiento hace un upadate del estado de la reservacion de A a I 

                        db.spEliminar_Reservacion(idReservacion, "I", fecha_actual);
                        Continuar = true;
                    }
                }
            }
            using (PV_ProyectoFinalEntities2 db1 = new PV_ProyectoFinalEntities2())
            {
                // Crea un nuevo registro en el historial de la reservacion con la accion de eliminada 

                db1.spCrear_Bitacora(idReservacion, Usu.Id, "CANCELADA", fecha_actual);
                Response.Redirect("~/Pages/Afirmaciones/Afirmacion_Eli.aspx");
            }
        }
    }
}