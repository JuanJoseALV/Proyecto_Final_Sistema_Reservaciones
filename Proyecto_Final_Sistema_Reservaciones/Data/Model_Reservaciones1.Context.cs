﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Proyecto_Final_Sistema_Reservaciones.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class PV_ProyectoFinalEntities1 : DbContext
    {
        public PV_ProyectoFinalEntities1()
            : base("name=PV_ProyectoFinalEntities1")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual ObjectResult<spConsultar_Bitacora_Result> spConsultar_Bitacora(Nullable<int> id_Reservacion)
        {
            var id_ReservacionParameter = id_Reservacion.HasValue ?
                new ObjectParameter("id_Reservacion", id_Reservacion) :
                new ObjectParameter("id_Reservacion", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spConsultar_Bitacora_Result>("spConsultar_Bitacora", id_ReservacionParameter);
        }
    
        public virtual ObjectResult<spConsultar_Mis_Reservaciones_Result> spConsultar_Mis_Reservaciones(Nullable<int> id_Persona)
        {
            var id_PersonaParameter = id_Persona.HasValue ?
                new ObjectParameter("id_Persona", id_Persona) :
                new ObjectParameter("id_Persona", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spConsultar_Mis_Reservaciones_Result>("spConsultar_Mis_Reservaciones", id_PersonaParameter);
        }
    
        public virtual ObjectResult<spConsultar_Reservaciones_ID_Result> spConsultar_Reservaciones_ID(Nullable<int> id_Reservacion)
        {
            var id_ReservacionParameter = id_Reservacion.HasValue ?
                new ObjectParameter("id_Reservacion", id_Reservacion) :
                new ObjectParameter("id_Reservacion", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spConsultar_Reservaciones_ID_Result>("spConsultar_Reservaciones_ID", id_ReservacionParameter);
        }
    
        public virtual ObjectResult<spValidar_Reservaciones_Persona_Result> spValidar_Reservaciones_Persona(Nullable<int> id_Reservacion, string nombre_Usuario)
        {
            var id_ReservacionParameter = id_Reservacion.HasValue ?
                new ObjectParameter("id_Reservacion", id_Reservacion) :
                new ObjectParameter("id_Reservacion", typeof(int));
    
            var nombre_UsuarioParameter = nombre_Usuario != null ?
                new ObjectParameter("Nombre_Usuario", nombre_Usuario) :
                new ObjectParameter("Nombre_Usuario", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spValidar_Reservaciones_Persona_Result>("spValidar_Reservaciones_Persona", id_ReservacionParameter, nombre_UsuarioParameter);
        }
    
        public virtual ObjectResult<spConsultar_Usuarios_Result> spConsultar_Usuarios(string email, string clave)
        {
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var claveParameter = clave != null ?
                new ObjectParameter("Clave", clave) :
                new ObjectParameter("Clave", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spConsultar_Usuarios_Result>("spConsultar_Usuarios", emailParameter, claveParameter);
        }
    
        public virtual ObjectResult<spGestionar_Reservaciones_ID_Result> spGestionar_Reservaciones_ID(Nullable<int> id_Persona)
        {
            var id_PersonaParameter = id_Persona.HasValue ?
                new ObjectParameter("id_Persona", id_Persona) :
                new ObjectParameter("id_Persona", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGestionar_Reservaciones_ID_Result>("spGestionar_Reservaciones_ID", id_PersonaParameter);
        }
    }
}
