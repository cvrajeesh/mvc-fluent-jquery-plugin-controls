# Introduction #

Lightweight but rich data grid with resizable columns and a scrolling data to match the headers, plus an ability to connect to an xml based data source using Ajax to load the content.

Please find more details about FlexiGrid from [here](http://code.google.com/p/flexigrid/)

This fluent mvc control wraps the functionalities of FlexiGrid, so that MVC developers could  use it without writing any single line of code.

# How to use #

Consider an example, in which you have view model like below

```
 public class EmployeeViewModel
    {
        public string Name { get; set; }
        public int Age { get; set; }
    }
```

and you want to display list of Employees in the FlexiGrid.

  * First download the MVC fluent JQuery control dll from the download section and add that to your project reference.
  * Include the javascript and css files for [FlexiGrid](http://code.google.com/p/flexigrid/) to your view or master page.
  * In the MVC view, include the FlexiGrid control like below

```
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
```

  * Create an POST action method called "Employees" (You could see the source code in the demo page listed below)

[Demo](http://www.nowiamin.com/)

# Road Map #

  * Create control with default options, so that user need not to set up all the settings.
  * Abstract the logic which Filter, Sort etc.. in controller action method.
  * Support for converting existing tables to FlexiGrid
  * Support for editing
  * Support for deleting