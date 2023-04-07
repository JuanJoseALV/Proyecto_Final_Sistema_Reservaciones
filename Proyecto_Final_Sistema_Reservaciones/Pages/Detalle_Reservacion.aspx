<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detalle_Reservacion.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Detalle_Reservacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin-top: 4%">
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
    <div style="margin-top: 2% ;">
        <asp:Button ID="BTN_Editar" runat="server" Text="Editar reservacion" Visible="False" />
        <asp:Button ID="BTN_Cancelar" runat="server" Text="Cancelar reservacion"  Visible="False" />
        <asp:Button ID="BTN_Regresar" runat="server" Text="Regresar" OnClick="Button1_Click" />
    </div>
    <div style="margin-top:3%">
         <asp:Label ID="Label1" runat="server" Text="Lista de acciones realizadas" ForeColor="Blue" Font-Size="X-Large"></asp:Label>
    </div>
    <div style="margin:2%">
        <asp:GridView ID="GV_Bit" runat="server" AutoGenerateColumns="False" >
            <Columns>
                <asp:BoundField HeaderText="Fecha" DataField="fechaDeLaAccion" />
                <asp:BoundField HeaderText="Accion" DataField="accionRealizada" />
                <asp:BoundField HeaderText="Realiazda por" DataField="nombreCompleto" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
