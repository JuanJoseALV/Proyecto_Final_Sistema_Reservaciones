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
                        List<spConsultar_Habitaciones_Id_Result> Habitaciones = db.spConsultar_Habitaciones_Id(idHabitacion).ToList();
                        foreach (spConsultar_Habitaciones_Id_Result Habitacion in Habitaciones)
                        {
                            TXT_Hotel.Text = Habitacion.nombre;
                             INP_Cantidad_Max.Value=Convert.ToString(Habitacion.capacidadMaxima);
                             INP_Descripcion.Value=Habitacion.descripcion;
                             INP_Numero_Habi.Value=Habitacion.numeroHabitacion;
                       
                        }
                    }
                    else
                    {
                        spValidar_Reservaciones_Persona_Result Reservaciones1 = db.spValidar_Reservaciones_Persona(idReservacion, Usu.Nombre_Completo).FirstOrDefault();
                        if (Reservaciones1 == null)
                        {
                            Response.Redirect("~/Pages/Mis_Reservaciones.aspx", false);
                        }
                       
                    }





                }

            }
        }

        protected void BTN_Inactivar_Click(object sender, EventArgs e)
        {
            int idHabitacion = Convert.ToInt32(Request.QueryString["idHabitacion"]);
            using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
            {
                Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                if (Usu.Rol == true)
                {
                    List<spValidar_Habitaciones_Reservaciones_Result> Habitaciones = db.spValidar_Habitaciones_Reservaciones(idHabitacion).ToList();
                    if(Habitaciones.Count != 0)
                    {
                        foreach (spValidar_Habitaciones_Reservaciones_Result Habitacion in Habitaciones)
                        {
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

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {

            bool Hotel = false;
            if (Page.IsValid == true)
            {
                try
                {

                    string nombre = TXT_Hotel.Text;
                    string Numero_Habi = INP_Numero_Habi.Value;
                    int Cantidad_Max = Convert.ToInt32(INP_Cantidad_Max.Value);
                    string Descripcion = INP_Descripcion.Value;
                  
                        using (PV_ProyectoFinalEntities db = new PV_ProyectoFinalEntities())
                        {
                            var lista_Habitaciones = new List<ListItem>();
                            lista_Habitaciones = db.spConsultar_Habitaciones().Where(h => h.numeroHabitacion == Numero_Habi && h.nombre == nombre).Select(h => new ListItem { Value = h.idHabitacion.ToString() }).ToList();
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

        protected void BTN_Regresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Lista_Habitaciones.aspx");
        }
    }
}