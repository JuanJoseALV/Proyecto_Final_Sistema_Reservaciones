<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mis_Reservaciones.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Mis_Reservaciones1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container" style="margin: 6%">
        <div>

        </div>
        <div>
            <asp:GridView ID="GVW_Reservaciones" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="None" OnRowDataBound="GVW_Reservaciones_RowDataBound" HorizontalAlign="Center" Width="640px">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:BoundField DataField="idReservacion" HeaderText="# de reservacion" />
                    <asp:BoundField DataField="nombre" HeaderText="Hotel" />
                    <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha entrada" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="fechaSalida" HeaderText="Fecha salida" DataFormatString="{0:d}" />
                    <asp:BoundField HeaderText="Costo" DataField="costoTotal" />
                    <asp:TemplateField HeaderText="Estado"></asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href="Detalle_Reservacion.aspx?idReservacion=<%# Eval("idReservacion") %>">Detalle</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
