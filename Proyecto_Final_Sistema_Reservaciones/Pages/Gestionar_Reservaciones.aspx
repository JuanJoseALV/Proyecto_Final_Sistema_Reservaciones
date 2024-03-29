﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gestionar_Reservaciones.aspx.cs" Inherits="Proyecto_Final_Sistema_Reservaciones.Pages.Gestionar_Reservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="margin: 6%">
        <div class="mb-3">
            <asp:Label ID="Label1" runat="server" Text="Gestionar reservaciones" ></asp:Label>
        </div>
        <div>
            <asp:Label ID="Label5" runat="server" style="display: inline-block;" Width="190px"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Campo necesario" Width="175" ControlToValidate="INP_Fecha_Entrada" CssClass="alert-danger"></asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Campo necesario" Width="175" ControlToValidate="INP_Fecha_Salida" CssClass="alert-danger"></asp:RequiredFieldValidator>
        </div>
        <div>
            <asp:Label ID="Label2" runat="server" Text="Nombre" ForeColor="Aqua" Width="122px"></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="Fecha Entrada" ForeColor="Aqua" Width="122px"></asp:Label>
            <asp:Label ID="Label4" runat="server" Text="Fecha Salida" ForeColor="Aqua" ></asp:Label>
        </div>
        <div>
            <asp:DropDownList ID="DL_Clientes" runat="server" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
            <input type="datetime" id="INP_Fecha_Entrada" placeholder="dd/MM/yyyy" runat="server" controltovalidate="INP_Fecha_Entrada">
            <input type="datetime" id="INP_Fecha_Salida" placeholder="dd/MM/yyyy" runat="server">
            <asp:Button ID="Button1" runat="server" Text="Filtrar" OnClick="Button1_Click" />
        </div>
        <div>
            <asp:Label ID="Label6" runat="server" Text="" style="display: inline-block;" Width="190px"></asp:Label>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Ingrese una fecha válida en formato dd/MM/yyyy" ControlToValidate="INP_Fecha_Entrada" CssClass="alert-warning" Width="175" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Ingrese una fecha válida en formato dd/MM/yyyy" ControlToValidate="INP_Fecha_Salida" CssClass="alert-warning" Width="175" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
        </div>
        <div style="margin-top: 2%">
            <a href="Crear_Reservaciones.aspx">Nueva reservacion</a>
        </div>
        <div style="margin-top: 2%">
            <asp:GridView ID="GVW_Gestionar" runat="server" AutoGenerateColumns="False" HorizontalAlign="Left" OnRowDataBound="GVW_Gestionar_RowDataBound" Width="640px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="idReservacion" HeaderText="# Reservacion" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="nombreCompleto" HeaderText="Cliente" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Hotel" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha Entrada" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy}">
                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="fechaSalida" HeaderText="Fecha Salida" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy}">
                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="costoTotal" HeaderText="Costo" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataFormatString="${0:#,0.00}">
                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Estado"></asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href="Detalle_Reservacion.aspx?idReservacion=<%# Eval("idReservacion") %>">Consultar</a>
                        </ItemTemplate>
                    </asp:TemplateField>
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
    </div>
     <style type="text/css">
        #<%= GVW_Gestionar.ClientID %> {
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
            text-decoration: none;
            text-shadow: 1px 1px 2px black, 0 0 25px aqua, 0 0 8px white;
            transition: .5s;
        }
           #<%= GVW_Gestionar.ClientID %> {
              border-color:chartreuse;
               border: solid 1px #525252;
             border-collapse: collapse;
          }
    </style>
</asp:Content>
