<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mis_Reservaciones.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Mis_Reservaciones1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin: 6%">
        <div class="mb-3">
            <asp:Label ID="Label1" runat="server" Text="Mi reservacion" ForeColor="Blue" Font-Size="X-Large"></asp:Label>
        </div>
        <div style="margin-top: 2%">
            <a href="Crear_Reservaciones.aspx">Nueva reservacion</a>
        </div>
        <div style="margin-top: 2%">
            <asp:GridView ID="GVW_Reservaciones" runat="server" AutoGenerateColumns="False" OnRowDataBound="GVW_Reservaciones_RowDataBound" HorizontalAlign="Left" Width="640px">
                <AlternatingRowStyle BackColor="Silver" />
                <Columns>
                    <asp:BoundField  DataField="idReservacion" HeaderText="# de reservacion" HeaderStyle-HorizontalAlign="Center">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Hotel">
                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha entrada" DataFormatString="{0:d}">
                        <HeaderStyle Font-Bold="True" Font-Overline="False" HorizontalAlign="Left" />
                        <ItemStyle Font-Bold="False" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fechaSalida" HeaderText="Fecha salida" DataFormatString="{0:d}">
                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField HeaderText="Costo" DataField="costoTotal" HeaderStyle-HorizontalAlign="Center" DataFormatString="${0:#,0.00}">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Estado">
                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href="Detalle_Reservacion.aspx?idReservacion=<%# Eval("idReservacion") %>">Consultar</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#999999" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
