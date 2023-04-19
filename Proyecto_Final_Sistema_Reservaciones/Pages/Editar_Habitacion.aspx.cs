using Proyecto_Final_Sistema_Reservaciones.Class;
using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Proyecto_Final_Sistema_Reservaciones.Pages
{
    public partial class Editar_Habitacion : System.Web.UI.Page
    {
        /*Se llama al método Page_Load cuando se carga la página y comprueba si el usuario ha iniciado sesión. Si el usuario no ha iniciado
          sesión, lo redirige a la página de inicio de sesión. Si el usuario ha iniciado sesión, obtiene el ID de la sala y del usuario de la
          cadena de consulta y la sesión, respectivamente. Si el usuario es administrador, carga la información de la sala desde la base de
          datos en los cuadros de texto correspondientes. Si el usuario no es administrador, comprueba si la reserva con el ID dado pertenece 
          al usuario. Si no es del usuario, lo redirige a la página que muestra sus reservas.*/

        protected void Page_Load(object sender, EventArgs e)
        {
            int idHabitacion = Convert.ToInt32(Request.QueryString["idHabitacion"]);
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
                        // Toma la informacion de la habitacion a modificar  

                        List<spConsultar_Habitaciones_Id_Result> Habitaciones = db.spConsultar_Habitaciones_Id(idHabitacion).ToList();
                        foreach (spConsultar_Habitaciones_Id_Result Habitacion in Habitaciones)
                        {
                            // Asigna la informacion a los campos correspondientes 
                            TXT_Hotel.Text = Habitacion.nombre;
                             INP_Cantidad_Max.Value=Convert.ToString(Habitacion.capacidadMaxima);
                             INP_Descripcion.Value=Habitacion.descripcion;
                             INP_Numero_Habi.Value=Habitacion.numeroHabitacion;
                       
                        }
                    }
                    else
                    {
                        // Si no es un Empleado lo devuelve a mis reservaciones 
                       
                        {
                            Response.Redirect("~/Pages/Mis_Reservaciones.aspx", false);
                        }
                       
                    }





                }

            }
        }

        /* se llama cuando se hace clic en el botón "Inactivar". Obtiene la identificación de la habitación de la cadena de consulta y verifica
           si la habitación tiene reservas. Si la habitación tiene reservas, comprueba si las reservas ya han finalizado. Si las reservas no han
           finalizado, redirige al usuario a una página de error. Si las reservas han finalizado, establece el estado de la habitación en "I" (inactivo)
           en la base de datos y redirige al usuario a una página de confirmación.*/

        protected void BTN_Inactivar_Click(object sender, EventArgs e)
        {
            // Toma el id de la habitacion 
            int idHabitacion = Convert.ToInt32(Request.QueryString["idHabitacion"]);
            using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
            {
                Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                if (Usu.Rol == true)
                {
                    // Valida si las habitaciones tienen reservaciones 

                    List<spValidar_Habitaciones_Reservaciones_Result> Habitaciones = db.spValidar_Habitaciones_Reservaciones(idHabitacion).ToList();
                    if(Habitaciones.Count != 0)
                    {
                        foreach (spValidar_Habitaciones_Reservaciones_Result Habitacion in Habitaciones)
                        {
                            // Valida que no sean reservaciones en proceseso o en espera y si no es asi inactiva la habitacion 

                            string estado = Habitacion.estado;
                            DateTime fecha_Salida = Habitacion.fechaSalida;
                            DateTime fecha_Actual = DateTime.Now;
                            if (estado != "I")
                            {
                                if (fecha_Salida < fecha_Actual)
                                {

                                }
                                else
                                {
                                    Response.Redirect("~/Pages/Errores/Error_Fecha_INV.aspx");
                                }
                            }
                            else
                            {
                                Response.Redirect("~/Pages/Errores/Error_ha_In.aspx");
                            }


                        }
                    }
                    else
                    {
                        // inactiva la habitacion por medio del id 

                        db.spInactivar_Habitacion(idHabitacion, "I");
                        Response.Redirect("~/Pages/Afirmaciones/Afirmacion_Inac_Habi.aspx");
                    }
                   
                }
                else
                {
                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }

            }
        }

        /* Se llama cuando se hace clic en el botón "Guardar". Primero comprueba si la página es válida. Si la página es válida,
         obtiene la información de la habitación de los cuadros de texto correspondientes. Luego verifica si ya existe una habitación
         con el mismo nombre y número en la base de datos. Si no existe una habitación con el mismo nombre y número, actualiza la información
         de la habitación en la base de datos y redirige al usuario a una página de confirmación. Si ya existe una habitación con el mismo
         nombre y número, muestra un mensaje de error.*/
        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {

            bool Hotel = false;
            if (Page.IsValid == true)
            {
                try
                {
                    // Toma la informacion para hacer el update 

                    string nombre = TXT_Hotel.Text;
                    string Numero_Habi = INP_Numero_Habi.Value;
                    int Cantidad_Max = Convert.ToInt32(INP_Cantidad_Max.Value);
                    string Descripcion = INP_Descripcion.Value;
                  
                        using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                        {
                            var lista_Habitaciones = new List<ListItem>();
                            lista_Habitaciones = db.spConsultar_Habitaciones().Where(h => h.numeroHabitacion == Numero_Habi && h.nombre == nombre).Select(h => new ListItem { Value = h.idHabitacion.ToString() }).ToList();
                            
                            // Valida si existe una habitacion con el mismo nombre a guardar 
                        
                            if (lista_Habitaciones.Count == 0)
                            {
                                Hotel = true;
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
                            
                            // Ejecuta el update 

                            int idHabitacion = Convert.ToInt32(Request.QueryString["idHabitacion"]);
                            db1.spEditar_Habitacion (idHabitacion, Numero_Habi, Cantidad_Max, Descripcion);
                                Response.Redirect("~/Pages/Afirmaciones/Afirmacion_Editar_Habi.aspx", false);
                            }
                        }
                


                }
                catch (Exception)
                {

                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }


            }
        }

        /*Se llama cuando se hace clic en el botón "Regresar". Simplemente redirige al usuario a la página que muestra la lista de
          habitaciones.*/

        protected void BTN_Regresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Lista_Habitaciones.aspx");
        }
    }
}