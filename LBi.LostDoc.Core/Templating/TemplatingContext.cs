/*
 * Copyright 2012 LBi Netherlands B.V.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. 
 */

using System.Collections.Generic;
using System.Linq;
using System.Runtime.Caching;
using System.Xml.Linq;

namespace LBi.LostDoc.Core.Templating
{
    public class TemplatingContext : ITemplatingContext
    {
        public TemplatingContext(ObjectCache cache, string basePath, TemplateData data, IEnumerable<IAssetUriResolver> resolvers, IFileProvider fileProvider)
        {
            this.BasePath = basePath;
            this.TemplateData = data;
            this.AssetUriResolvers = resolvers.ToArray();
            this.FileProvider = fileProvider;
            this.Cache = cache;
        }

        #region ITemplatingContext Members

        public string BasePath { get; protected set; }

        public TemplateData TemplateData { get; protected set; }

        public IAssetUriResolver[] AssetUriResolvers { get; protected set; }

        public IFileProvider FileProvider { get; protected set; }

        #endregion

        public ObjectCache Cache { get; private set; }
    }
}
