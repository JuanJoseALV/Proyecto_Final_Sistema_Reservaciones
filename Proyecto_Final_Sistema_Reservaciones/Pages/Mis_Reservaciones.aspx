<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mis_Reservaciones.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Mis_Reservaciones1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin: 6%">
        <div class="mb-3">
            <asp:Label ID="Label1" runat="server" Text="Mi reservacion" ></asp:Label>
        </div>
        <div style="margin-top: 2%">
            <a style="color:white; font-size:large" href="Crear_Reservaciones.aspx">Nueva reservacion</a>
        </div>
        <div style="margin-top: 2%">
            <asp:GridView ID="GVW_Reservaciones" runat="server" AutoGenerateColumns="False" OnRowDataBound="GVW_Reservaciones_RowDataBound" HorizontalAlign="Left" Width="640px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#DCDCDC" />
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
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
        </div>
    </div>
      <style type="text/css">
        #<%= GVW_Reservaciones.ClientID %> {
            color: deepskyblue;
            font-size:large; 
            border: solid 2px #525252;
            border-collapse: collapse;
        }
        #<%= Label1.ClientID %> {
            color: aqua;
            text-shadow: 1px 1px 2px black, 0 0 25px aqua, 0 0 8px white;
            font-size:xx-large;
        }
      
         a:hover{
             color: aqua;
            text-shadow: 1px 1px 2px black, 0 0 25px aqua, 0 0 8px white;
        }
          #<%= GVW_Reservaciones.ClientID %> {
              border-color:chartreuse;
               border: solid 1px #525252;
             border-collapse: collapse;
          }
    </style>
</asp:Content>
