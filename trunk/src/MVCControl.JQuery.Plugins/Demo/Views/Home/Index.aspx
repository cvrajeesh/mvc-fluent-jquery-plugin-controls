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
           .Name("flex1") // Id of the underlying table element.
           .UpdateAction(Url.Action("Employees")) // Url of the action method which fetches and sort the data.
           .Columns(columns => // Columns that needs to be displayed.
               { 
                   // Column Name with
                   // Width - 180 pixels
                   // Title - "Name"
                   // Sortable
                   // Aligned - Left
                   columns.Bound(e => e.Name).Width(180).Title("Name").Sortable().Align(FlexiGridAlign.Left);
                   columns.Bound(e => e.Age).Width(180).Title("Age").Sortable().Align(FlexiGridAlign.Right); ;
               })
            // Default sort column
            .DefaultSortOption("Name", FlexiGridSortOrder.Ascending)
            // Display pager
            .UsePager()
            // Grid title
            .Title("Employees")
            // Maximum records per a page
            .RecordsPerPageOption(true, 15)
            // Show the toggle button 
            .ShowTableToggleButton(true)
            // Grid width
            .Width(800)
            // Grid height
            .Height(200) %>
    </p>
    <h2>Code</h2>
    <div id="tabs">
        <ul>
            <li><a href="#tabs-1">MVC View</a></li>
            <li><a href="#tabs-2">Controller</a></li>
        </ul>
        <div id="tabs-1">
            <pre>
            <code>
            &lt;%= Html.FlexiGrid&lt;EmployeeViewModel&gt;()
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
            .Height(200) %&gt;
            </code>
            </pre>
        </div>
        <div id="tabs-2">
            <pre>
                <code>
                [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Employees(FlexGridFetchOptions fetchOptions)
        {
            IQueryable&lt;EmployeeViewModel&gt; queryable = this.employees.AsQueryable&lt;EmployeeViewModel&gt;();

            IEnumerable&lt;EmployeeViewModel&gt; queriedEmployees = null;
            string query = string.Empty;

            if (fetchOptions.query.Length &gt; 0)
            {
                query = string.Format("{0}.Contains(@0)", fetchOptions.qtype);
            }

            string orderString = string.Format("{0}{1}", fetchOptions.sortname, (fetchOptions.sortorder == "desc") ? " descending" : string.Empty);

            queryable = queryable
                .Skip((fetchOptions.page - 1) * fetchOptions.rp)
                .Take(fetchOptions.rp);

            if (query.Length &gt; 0)
            {

                queryable = queryable.Where(query, fetchOptions.query);

            }

            if (fetchOptions.sortname.Length &gt; 0)
            {
                queryable = queryable.OrderBy(orderString);
            }

            queriedEmployees = queryable;

            var data = new FlexGridData&lt;EmployeeViewModel&gt;(
                queriedEmployees,
                fetchOptions.page,
                this.employees.Count, x =&gt; x.Name, y =&gt;
                {
                    y.Add(z =&gt; z.Name);
                    y.Add(z =&gt; z.Age);
                });

            return Json(data);
        }
                </code>
            </pre>
        </div>
        
    </div>
    
   <script type="text/javascript">
       $(function() {
       $("#tabs").tabs({ collapsible: true });
       });
	</script>
</asp:Content>
