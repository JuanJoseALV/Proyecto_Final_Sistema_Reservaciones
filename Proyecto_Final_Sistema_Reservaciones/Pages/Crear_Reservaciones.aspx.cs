using Proyecto_Final_Sistema_Reservaciones.Class;
using Proyecto_Final_Sistema_Reservaciones.Data;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Configuration;
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
                    using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
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

                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }
                INP_Num_A.Value = Convert.ToString(1);
                INP_Num_N.Value = Convert.ToString(0);
            }
        }

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            bool Hotel = false;
            if (Page.IsValid == true)
            {
                string idHotel1 = DL_Hotel.SelectedItem.Value;
                string idPersona1 = DL_Cliente.SelectedItem.Value;
                if (string.IsNullOrEmpty(idHotel1) == false)
                {
                    if (string.IsNullOrEmpty(idPersona1) == false)
                    {
                        try
                        {
                            int idHotel = Convert.ToInt32(DL_Hotel.SelectedItem.Value);
                            int idPersona = Convert.ToInt32(DL_Cliente.SelectedItem.Value);
                            DateTime fechaEntrada = Convert.ToDateTime(INP_Fecha_En.Value);
                            DateTime fechaSalida = Convert.ToDateTime(INP_Fecha_Sal.Value);
                            int numeroAdultos = Convert.ToInt32(INP_Num_A.Value);
                            int numeroNinhos = Convert.ToInt32(INP_Num_N.Value);
                            int totalDiasReservacion = (fechaSalida - fechaEntrada).Days;
                            DateTime fechaCreacion = DateTime.Now;
                            string estado = "A";
                            int numPersonas = numeroAdultos + numeroNinhos;

                            decimal costoPorCadaAdulto = 0;
                            decimal costoPorCadaNinho = 0;
                            decimal costoTotal = 0;

                            using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
                            {
                                spValidar_Habitaciones_Result Habi = db.spValidar_Habitaciones(idHotel, numPersonas).FirstOrDefault();
                                if (Habi != null)
                                {
                                    spConsultar_Hoteles_Id_Result reserva = db.spConsultar_Hoteles_Id(idHotel).FirstOrDefault();
                                    if (reserva != null)
                                    {
                                        costoPorCadaAdulto = reserva.costoPorCadaAdulto;
                                        costoPorCadaNinho = reserva.costoPorCadaNinho;
                                        costoTotal = (costoPorCadaAdulto * numeroAdultos) + (costoPorCadaNinho * numeroNinhos);

                                        db.spCrear_Reservacion(numPersonas, idHotel, idPersona, fechaEntrada, fechaSalida, numeroAdultos,
                                        numeroNinhos, totalDiasReservacion, costoPorCadaAdulto, costoPorCadaNinho, costoTotal, fechaCreacion, estado);
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
                                using (PV_ProyectoFinalEntities2 db1 = new PV_ProyectoFinalEntities2())
                                {
                                    int? Reservacion = db1.Database.SqlQuery<int?>("EXEC spObtener_Id_Reservacion_Creada").FirstOrDefault();
                                    if (Reservacion != null)
                                    {
                                        Usuarios Usu = (Usuarios)Session["Usuario_Res"];
                                        int Id_Reservacion = Reservacion.Value;
                                        db1.spCrear_Bitacora(Id_Reservacion, Usu.Id, "CREADA", fechaCreacion);
                                        Response.Redirect("~/Pages/Afirmaciones/Afirmacion.aspx",false);
                                    }
                                }
                            }

                        }
                        catch (Exception)
                        {

                            Response.Redirect("~/Pages/Errores/Error.aspx");
                        }
                    }
                }
                    
                
                   
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

        protected void CV_Fecha_En_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;
            if (DateTime.TryParseExact(args.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha))
            {
                if (fecha <= DateTime.Now)
                {
                    
                    args.IsValid = false;
                    CV_Fecha_En.ErrorMessage = "La fecha de entrada debe ser menor que la fecha actual.";
                }
                else
                {
                    args.IsValid = true;
                }
            }
            else
            {
                args.IsValid = false;
                CV_Fecha_En.ErrorMessage = "El formato de la fecha entrada es inválido.";
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