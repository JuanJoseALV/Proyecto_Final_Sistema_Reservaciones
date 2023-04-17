<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error_Fecha_INV.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Errores.Error_Fecha_INV" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin-top: 10%; margin-left: 30%">
        <asp:Label ID="Label1" runat="server" Text="No se puede Inactivar una habitacion con reservaciones en espera o en proceso" CssClass="danger" ForeColor="Red" Font-Size="X-Large"></asp:Label>
        <div>
            <a href="../Lista_Habitaciones.aspx">Regresar</a>
        </div>
    </div>

</asp:Content>
