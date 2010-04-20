// --------------------------------------------------------------------------------------------------------------------
// <copyright file="IGridRenderer.cs" company="OpenSource :)">
//   Copyright (c) 2010 Rajeesh.C.V(www.rajeeshcv.com). Licensed under the MIT (MIT-LICENSE.txt)
// </copyright>
// <summary>
//   Defines the IGridRenderer type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace MVCControl.JQuery.Plugins.Core
{
    /// <summary>
    /// Interface that needs to be implemented by all the Grid renderers.
    /// </summary>
    /// <typeparam name="T">Type of the data that needs to be rendered.</typeparam>
    public interface IGridRenderer<T> where T : class 
    {
        /// <summary>
        /// Renders the specified data.
        /// </summary>
        /// <param name="data">The data that needs to be rendered..</param>
        /// <returns>Rendered output as string.</returns>
        string Render(T data);
    }
}
