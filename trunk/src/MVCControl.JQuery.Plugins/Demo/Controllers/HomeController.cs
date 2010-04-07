using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Web.Mvc;
using MVCControl.JQuery.Plugins.FlexiGrid;
using MVCControl.JQuery.Plugins.FlexiGrid.Model;
using MVCTestProject.Models;

namespace Demo.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        private IList<EmployeeViewModel> employees = null;
        public HomeController()
        {
            this.employees = new List<EmployeeViewModel>();

            for (int i = 0; i < 100; i++)
            {
                this.employees.Add(new EmployeeViewModel { Name = "Employee" + i.ToString(), Age = i * 2 });
            }
        }


        public ActionResult Index()
        {
            return View();
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Employees(FlexGridFetchOptions fetchOptions)
        {
            IQueryable<EmployeeViewModel> queryable = this.employees.AsQueryable<EmployeeViewModel>();

            IEnumerable<EmployeeViewModel> queriedEmployees = null;
            string query = string.Empty;

            if (fetchOptions.query.Length > 0)
            {
                query = string.Format("{0}.Contains(@0)", fetchOptions.qtype);
            }

            string orderString = string.Format("{0}{1}", fetchOptions.sortname, (fetchOptions.sortorder == "desc") ? " descending" : string.Empty);

            queryable = queryable
                .Skip((fetchOptions.page - 1) * fetchOptions.rp)
                .Take(fetchOptions.rp);

            if (query.Length > 0)
            {

                queryable = queryable.Where(query, fetchOptions.query);

            }

            if (fetchOptions.sortname.Length > 0)
            {
                queryable = queryable.OrderBy(orderString);
            }

            queriedEmployees = queryable;

            var data = new FlexGridData<EmployeeViewModel>(
                queriedEmployees,
                fetchOptions.page,
                this.employees.Count, x => x.Name, y =>
                {
                    y.Add(z => z.Name);
                    y.Add(z => z.Age);
                });

            return Json(data);
        }
    }
}
