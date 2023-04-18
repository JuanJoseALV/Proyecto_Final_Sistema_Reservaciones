using Microsoft.Ajax.Utilities;
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
    public partial class Crear_Habitaciones : System.Web.UI.Page
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
                        var lista_Hoteles = new List<ListItem>();
                        lista_Hoteles = db.spConsultar_Hoteles().Select(_ => new ListItem { Text = _.nombre, Value = _.idHotel.ToString() }).ToList();
                        ListItem primer_elemento_Hoteles = new ListItem("Seleccione un hotel", "");
                        lista_Hoteles.Insert(0, primer_elemento_Hoteles);
                        DL_Habitacion.DataSource = lista_Hoteles;
                        DL_Habitacion.DataBind();
                    }

                }
                catch (Exception)
                {

                    Response.Redirect("~/Pages/Errores/Error.aspx");
                }
                INP_Cantidad_Max.Value = Convert.ToString(1);
            }
        }

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            bool Hotel = false;
            if (Page.IsValid == true)
            {
                try
                {
                    string idHotel = DL_Habitacion.SelectedItem.Value;
      
                    string Numero_Habi = INP_Numero_Habi.Value;
                    int Cantidad_Max = Convert.ToInt32(INP_Cantidad_Max.Value);
                    string Descripcion = INP_Descripcion.Value;
                    string estado = "A";
                    if (string.IsNullOrEmpty(idHotel)==false)
                    {
                        int idHotel1 = Convert.ToInt32(DL_Habitacion.SelectedItem.Value);
                        using (PV_ProyectoFinalEntities2 db = new PV_ProyectoFinalEntities2())
                        {
                            var lista_Habitaciones = new List<ListItem>();
                            lista_Habitaciones = db.spConsultar_Habitaciones().Where(h => h.numeroHabitacion == Numero_Habi && h.idHotel == idHotel1).Select(h => new ListItem { Value = h.idHabitacion.ToString() }).ToList();
                            if (lista_Habitaciones.Count == 0 )
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
                            using (PV_ProyectoFinalEntities2 db1 = new PV_ProyectoFinalEntities2())
                            {
                                db1.spCrear_Habitacion(idHotel1, Numero_Habi, Cantidad_Max, Descripcion, estado);
                                Response.Redirect("~/Pages/Afirmaciones/Afirmacion_Crear_Habi.aspx",false);
                            }
                        }
                    }
                    else
                    {
                        LBl_Validacion_Ho.Visible = true;
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