<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error_ha_In.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Errores.Error_ha_In" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin-top: 10%; margin-left: 30%">
        <asp:Label ID="Label1" runat="server" Text="No se puede Inactivar una habitacion que este inactiva" CssClass="danger" ForeColor="Red" Font-Size="X-Large"></asp:Label>
        <div>
            <a href="../Lista_Habitaciones.aspx">Regresar</a>
        </div>
    </div>

</asp:Content>
