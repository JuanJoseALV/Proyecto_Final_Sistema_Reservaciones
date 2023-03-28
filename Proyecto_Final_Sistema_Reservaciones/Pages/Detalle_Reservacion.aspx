<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detalle_Reservacion.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Detalle_Reservacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView runat="server" AutoGenerateColumns="False" ID="GVW_Detalle">
        <Columns>
            <asp:BoundField DataField="idReservacion" HeaderText="# Reservacion" />
            <asp:BoundField DataField="nombre" HeaderText="Hotel" />
            <asp:BoundField DataField="numeroHabitacion" HeaderText="Numero de habitacion" />
            <asp:BoundField DataField="nombreCompleto" HeaderText="Cliente" />
            <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha entrada" />
            <asp:BoundField DataField="fechaSalida" HeaderText="Fecha salida" />
            <asp:BoundField HeaderText="Dias de reserva" />
            <asp:BoundField DataField="numeroNinhos" HeaderText="Numero de niños" />
            <asp:BoundField DataField="numeroAdultos" HeaderText="Numero de adultos" />
            <asp:BoundField DataField="costoTotal" HeaderText="Costo total" />
        </Columns>
    </asp:GridView>
    <asp:GridView ID="GridView1" runat="server">
        <Columns>
            <asp:BoundField DataField="idReservacion" HeaderText="# Reservacion" />
            <asp:BoundField DataField="nombre" HeaderText="Hotel" />
            <asp:BoundField DataField="numeroHabitacion" HeaderText="Numero de habitacion" />
            <asp:BoundField DataField="nombreCompleto" HeaderText="Cliente" />
            <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha entrada" />
            <asp:BoundField DataField="fechaSalida" HeaderText="Fecha salida" />
            <asp:BoundField DataField="numeroNinhos" HeaderText="Numero de niños" />
            <asp:BoundField DataField="numeroAdultos" HeaderText="Numero de adultos" />
            <asp:BoundField DataField="costoTotal" HeaderText="Costo total" />
        </Columns>

    </asp:GridView>
    <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
</asp:Content>
