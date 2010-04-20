<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="MVCTestProject.Models"%>
<%@ Import Namespace="MVCControl.JQuery.Plugins.FlexiGrid"%>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	LimitedOptions
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>LimitedOptions</h2>
    <p>
        <%= Html.FlexiGrid<EmployeeViewModel>()
           .UpdateAction(Url.Action("Employees")) // Url of the action method which fetches and sort the data.
           .Columns(columns => // Columns that needs to be displayed.
               { 
                   // Column Name with
                   // Width - 180 pixels
                   // Title - "Name"
                   // Sortable
                   // Aligned - Left
                   columns.Bound(e => e.Name).Width(180);
                   columns.Bound(e => e.Age).Width(180);
               })
            // Default sort column
            .DefaultSortOption("Name", FlexiGridSortOrder.Ascending)
            
            %>
    </p>

</asp:Content>
