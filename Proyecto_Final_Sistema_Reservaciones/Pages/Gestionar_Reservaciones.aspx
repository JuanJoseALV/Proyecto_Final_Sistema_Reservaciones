<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gestionar_Reservaciones.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Gestionar_Reservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin: 6%">
        <div class="mb-3">
            <asp:Label ID="Label1" runat="server" Text="Gestionar reservaciones" ForeColor="Blue" Font-Size="X-Large"></asp:Label>
        </div>
        <div style="margin-top: 2%">
            <asp:LinkButton ID="LinkButton1" runat="server" >Nueva reservacion</asp:LinkButton>
        </div>
        <div style="margin-top: 2%">
            <asp:GridView ID="GVW_Gestionar" runat="server" AutoGenerateColumns="False" HorizontalAlign="Left" OnRowDataBound="GVW_Gestionar_RowDataBound" Width="640px">
                <AlternatingRowStyle BackColor="Silver" />
                <Columns>
                    <asp:BoundField DataField="idReservacion" HeaderText="# Reservacion" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="nombreCompleto" HeaderText="Cliente" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left"/>
                    <asp:BoundField DataField="nombre" HeaderText="Hotel" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left"/>
                    <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha Entrada" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="fechaSalida" HeaderText="Fecha Salida" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="costoTotal" HeaderText="Costo" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" />
                    <asp:TemplateField HeaderText="Estado"></asp:TemplateField>
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
