<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detalle_Reservacion.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Detalle_Reservacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin-top: 4%">
        <div>
            <asp:Label ID="Label8" runat="server" >Detalle reservacion</asp:Label>
        </div>
        <div>
            <asp:DataList ID="dtl_Detalle" runat="server" Width="800px">
                <HeaderTemplate>
                    <table border="1">
                        <thead>
                            <tr>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>Id reservacion</td>
                        <td><asp:Label ID="idReservacionLabel" runat="server" Text='<%# Eval("idReservacion") %>' /></td>
                    </tr>
                    <tr>
                        <td>Hotel</td>
                        <td><asp:Label ID="Label1" runat="server" Text='<%# Eval("nombre") %>' /></td>
                    </tr>
                    <tr>
                        <td>Numero Habitacion</td>
                        <td><asp:Label ID="Label2" runat="server" Text='<%# Eval("numeroHabitacion") %>' /></td>
                    </tr>
                    <tr>
                        <td>Nombre Completo</td>
                        <td><asp:Label ID="Label3" runat="server" Text='<%# Eval("nombreCompleto") %>' /></td>
                    </tr>
                    <tr>
                        <td>Fecha Entrada</td>
                        <td><asp:Label ID="Label4" runat="server" Text='<%# Eval("fechaEntrada", "{0:dd/MM/yyyy}") %>' /></td>
                    </tr>
                    <tr>
                        <td>Fecha Salida</td>
                         <td><asp:Label ID="Label5" runat="server" Text='<%# Eval("fechaSalida", "{0:dd/MM/yyyy}") %>' /></td>
         
                    </tr>
                    <tr>
                        <td>Dias de la reserva</td>
                        <td><%# GetReservationDays(Eval("FechaEntrada").ToString(), Eval("FechaSalida").ToString()) %></td>
                    </tr>
                    <tr>
                        <td>Numero Niños</td>
                        <td><asp:Label ID="Label6" runat="server" Text='<%# Eval("numeroNinhos") %>' /></td>
                    </tr>
                    <tr>
                        <td>Numero Adultos</td>
                        <td><asp:Label ID="Label7" runat="server" Text='<%# Eval("numeroAdultos") %>' /></td>
                    </tr>
                    <tr>
                        <td>Costo Total</td>
                        <td><%# GetReservationCost(Convert.ToDouble(Eval("costoTotal"))) %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:DataList>
        </div>
    </div>
    <div style="margin-top: 2% ">
        <asp:Button ID="BTN_Editar" runat="server" Text="Editar reservacion" Visible="False" OnClick="BTN_Editar_Click"/>
        <asp:Button ID="BTN_Cancelar" runat="server" Text="Cancelar reservacion"  Visible="False" OnClick="BTN_Cancelar_Click" />
        <asp:Button ID="BTN_Regresar" runat="server" Text="Regresar" OnClick="Button1_Click" />
    </div>
    <div style="margin-top:3%">
         <asp:Label ID="Label1" runat="server">Lista de acciones realizadas</asp:Label>
    </div>
    <div style="margin-top:2%">
        <asp:GridView ID="GV_Bit" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" >
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:BoundField HeaderText="Fecha" DataField="fechaDeLaAccion" />
                <asp:BoundField HeaderText="Accion" DataField="accionRealizada" />
                <asp:BoundField HeaderText="Realiazda por" DataField="nombreCompleto" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#0000A9" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#000065" />
        </asp:GridView>
    </div>
    <style type="text/css">
        #<%= dtl_Detalle.ClientID %> {
            color: aqua;
            font-size:large;
        }
        #<%= GV_Bit.ClientID %> {
            font-size:large;
        }
        #<%= Label8.ClientID %>{
           color: aqua;
            text-shadow: 1px 1px 2px black, 0 0 25px aqua, 0 0 8px white;
            font-size:xx-large;
        }
        #<%= BTN_Editar.ClientID %>{
             background-color:blue;
            border-radius: 12px;
            color:white;
            width:auto;
       
        }
        #<%= BTN_Editar.ClientID%>:hover{
             background-color:aqua;
        }
        #<%= BTN_Cancelar.ClientID %>{
             background-color:maroon;
            border-radius: 12px;
            color:white;
            width:auto;
        }
        #<%= BTN_Cancelar.ClientID%>:hover{
             background-color:red;
        }
        #<%= BTN_Regresar.ClientID %>{
             background-color:darkgreen;
            border-radius: 12px;
            color:white;
            width:auto;
        }
        #<%= BTN_Regresar.ClientID%>:hover{
             background-color:chartreuse;
        }
        #<%= Label1.ClientID %>{
            color: aqua;
            text-shadow: 1px 1px 2px black, 0 0 25px aqua, 0 0 8px white;
            font-size:xx-large;
        }
     
    </style>
</asp:Content>
