<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lista_Habitaciones.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.LIsta_Habitaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="container" style="margin: 6%">
        <div class="mb-3">
            <asp:Label ID="Label1" runat="server" Text="Lista de Habitaciones" ></asp:Label>
        </div>
        <div style="margin-top: 2%">
            <a style="color:white; font-size:large" href="Crear_Habitaciones.aspx" >Crear habitacion</a>
        </div>
        <div style="margin-top: 2%">
            <asp:GridView ID="GVW_Habitaciones" runat="server" AutoGenerateColumns="False"  HorizontalAlign="Left" Width="696px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" OnRowDataBound="GVW_Habitaciones_RowDataBound">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField  DataField="idHabitacion" HeaderText="ID" HeaderStyle-HorizontalAlign="Center">
            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Hotel">
                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="numeroHabitacion" HeaderText="Numero Habitacion">
                        <HeaderStyle Font-Bold="True" Font-Overline="False" HorizontalAlign="Left" />
                        <ItemStyle Font-Bold="False" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="capacidadMaxima" HeaderText="Capacidad maxima">
                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Estado">
                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href="Editar_Habitacion.aspx?idHabitacion=<%# Eval("idHabitacion") %>">Modificar</a>
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
        #<%= GVW_Habitaciones.ClientID %> {
           font-size:large; 
           
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
       
    </style>
</asp:Content>
