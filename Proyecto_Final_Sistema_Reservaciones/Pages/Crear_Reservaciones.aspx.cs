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

        /*El método Page_Load se ejecuta cuando se carga la página. Primero comprueba si el usuario está logueado o no comprobando
          si la variable de sesión "Usuario_Res" es nula. Si es nulo, se redirige al usuario a la página de inicio de sesión. De lo
          contrario, verifica si la página se está cargando por primera vez o si es una devolución de datos. Si es la primera vez,
          llena los controles DropDownList DL_Cliente y DL_Hotel con datos de la base de datos. Si el usuario es un administrador,
          DL_Cliente se completa con una lista de todos los clientes en la base de datos. Si el usuario es un cliente, DL_Cliente se
          completa solo con el propio nombre del cliente. DL_Hotel se completa con una lista de todos los hoteles en la base de datos.*/

        protected void Page_Load(object sender, EventArgs e)
        {

            // Este proceso verifica si el usuario ya inicio sesion de lo contrario lo envia a la pagina de login

            Usuarios Usu = (Usuarios)Session["Usuario_Res"];
            if (Usu == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
            }
            if (Page.IsPostBack == false)
            {
                try
                {
                    /* Este proceso valida si es un empleado o no lo que diferencia el uno del otro es la variable de nombre del usuario
                       en el caso del empleado se llena con el nombre del cliente que el eligio y si es usuario normal se llena con el nombre 
                       del usuario logueado*/
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
                
                // Aqui inicializa los inputs de numero de niños y adultos
               
                INP_Num_A.Value = Convert.ToString(1);
                INP_Num_N.Value = Convert.ToString(0);
            }
        }

        /*El método BTN_Guardar_Click se ejecuta cuando el usuario hace clic en el botón "Guardar". Primero, verifica si la página
          es válida usando la propiedad Page.IsValid. Luego, recupera el hotel y el cliente seleccionados de los controles DropDownList
          DL_Hotel y DL_Cliente, respectivamente. Si ambos valores no son nulos o están vacíos, el método intenta crear una reserva en la
          base de datos llamando al procedimiento almacenado spCrear_Reservacion. El procedimiento almacenado toma varios parámetros, como
          la cantidad de adultos y niños, las identificaciones del hotel y del cliente, las fechas de inicio y finalización de la reserva,
          y calcula el costo total de la reserva. Si la reserva se crea correctamente, el método establece una variable booleana Hotel en
          verdadero y redirige al usuario a una página de confirmación. Si no se puede crear la reserva,*/

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            bool Hotel = false;
            
            // Aqui valida si las validaciones se cumplen si es asi continua con el proceso de insercion de reservaciones

            if (Page.IsValid == true)
            {

                // Estas validaciones son para ver si son valores iniciales a los de default de los DropDown

                string idHotel1 = DL_Hotel.SelectedItem.Value;
                string idPersona1 = DL_Cliente.SelectedItem.Value;
                if (string.IsNullOrEmpty(idHotel1) == false)
                {
                    if (string.IsNullOrEmpty(idPersona1) == false)
                    {
                        try
                        {

                            // En este proceso se toma la informacio requerida para hacer el insercion en la base de datos 

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
                                /* Este procedimiento valida por medio de una consulta si existe una habitacion con la capacidad suficiete
                                   en el caso que no exista se le pide al usuario seleccionar otro Hotel*/

                                spValidar_Habitaciones_Result Habi = db.spValidar_Habitaciones(idHotel, numPersonas).FirstOrDefault();
                                if (Habi != null)
                                {
                                    /* Este procedimiento se hace para tomar el precio por niños y adultos del hotel seleccionado
                                       para posteriormente calcular el precio total*/
                                    spConsultar_Hoteles_Id_Result reserva = db.spConsultar_Hoteles_Id(idHotel).FirstOrDefault();
                                    if (reserva != null)
                                    {
                                        costoPorCadaAdulto = reserva.costoPorCadaAdulto;
                                        costoPorCadaNinho = reserva.costoPorCadaNinho;
                                        costoTotal = (costoPorCadaAdulto * numeroAdultos) + (costoPorCadaNinho * numeroNinhos);
                                        
                                        // Este procedimiento se encarga de crear la insercion en la base de datos
                                        
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
                             
                            // Este proceso se ejecuta unicamente si el proceso anterio se completa con exito 

                            if (Hotel == true)
                            {
                                using (PV_ProyectoFinalEntities2 db1 = new PV_ProyectoFinalEntities2())
                                {
                                    // Este proceso toma el id de la reservacion mas reciente en la base de datos 

                                    int? Reservacion = db1.Database.SqlQuery<int?>("EXEC spObtener_Id_Reservacion_Creada").FirstOrDefault();
                                    if (Reservacion != null)
                                    {
                                        // Este procedimiento crea un registro en la bitacora con la informacionde el id de reservacion

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


        /*El método CV_Fecha_Sal_ServerValidate se ejecuta cuando se está validando la fecha de finalización de la reserva.
          Si la fecha no tiene un formato válido, la validación falla y se muestra un mensaje de error al usuario. De lo contrario,
          el método comprueba si la fecha de finalización es mayor o igual que la fecha de inicio. Si no es así, la validación falla
          y se muestra un mensaje de error al usuario.*/
        protected void CV_Fecha_Sal_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //Aqui se toma la fecha de salida se valida el formato y si es correcto se toma la fecha de entrada y se valida el formato  

            DateTime fecha;
            if (DateTime.TryParseExact(args.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha))
            {
                DateTime fecha_en;
                if (DateTime.TryParseExact(INP_Fecha_En.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out fecha_en))
                { 
                    // Valida si la fecha de salida es mayor a la fecha actual si es asi el arguameto es verdadero, si no , se envia una alerta

                    if (fecha >= DateTime.Now)
                    {
                        // Valida si la fecha de entrada es mayor a la fecha de salida y si es asi envia una alerta de lo contario el argumento es verdadero 

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

        //Comprueba si la fecha ingresada está en el formato correcto y es mayor que la fecha de hoy. Si la fecha no es válida se envia una alerta

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

        //Se llama cuando se hace clic en el botón "Regresar". Comprueba el rol del usuario y lo redirige a la página adecuada según su rol.

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