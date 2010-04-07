<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="MVCTestProject.Models"%>
<%@ Import Namespace="MVCControl.JQuery.Plugins.FlexiGrid"%>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>With all the options</h2>
    <p>
        <%= Html.FlexiGrid<EmployeeViewModel>()
           .Name("flex1")
                       .UpdateAction(Url.Action("Employees"))
           .Columns(columns =>
               { 
                   columns.Bound(e => e.Name).Width(180).Title("Name").Sortable().Align(FlexiGridAlign.Left);
                   columns.Bound(e => e.Age).Width(180).Title("Age").Sortable().Align(FlexiGridAlign.Right); ;
               })
            .DefaultSortOption("Name", FlexiGridSortOrder.Ascending)
            .UsePager()
            .Title("Employees")
            .RecordsPerPageOption(true, 15) 
            .ShowTableToggleButton(true)
            .Width(800)
            .Height(200) %>
    </p>
</asp:Content>
