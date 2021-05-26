/**
 * Provides classes for working with JavaScript programs, as well as JSON, YAML and HTML.
 */

import Customizations
import semmle.javascript.Aliases
import semmle.javascript.AMD
import semmle.javascript.ApiGraphs
import semmle.javascript.Arrays
import semmle.javascript.AST
import semmle.javascript.BasicBlocks
import semmle.javascript.Base64
import semmle.javascript.CFG
import semmle.javascript.Classes
import semmle.javascript.Closure
import semmle.javascript.Collections
import semmle.javascript.Comments
import semmle.javascript.Concepts
import semmle.javascript.Constants
import semmle.javascript.DefUse
import semmle.javascript.DOM
import semmle.javascript.E4X
import semmle.javascript.EmailClients
import semmle.javascript.Errors
import semmle.javascript.ES2015Modules
import semmle.javascript.Expr
import semmle.javascript.Extend
import semmle.javascript.Externs
import semmle.javascript.Files
import semmle.javascript.Functions
import semmle.javascript.Generators
import semmle.javascript.GlobalAccessPaths
import semmle.javascript.HTML
import semmle.javascript.HtmlSanitizers
import semmle.javascript.InclusionTests
import semmle.javascript.JSDoc
import semmle.javascript.JSON
import semmle.javascript.JsonParsers
import semmle.javascript.JsonSchema
import semmle.javascript.JsonStringifiers
import semmle.javascript.JSX
import semmle.javascript.Lines
import semmle.javascript.Locations
import semmle.javascript.MembershipCandidates
import semmle.javascript.Modules
import semmle.javascript.NodeJS
import semmle.javascript.NPM
import semmle.javascript.Paths
import semmle.javascript.Promises
import semmle.javascript.CanonicalNames
import semmle.javascript.RangeAnalysis
import semmle.javascript.Regexp
import semmle.javascript.SSA
import semmle.javascript.StandardLibrary
import semmle.javascript.Stmt
import semmle.javascript.StringConcatenation
import semmle.javascript.StringOps
import semmle.javascript.Templates
import semmle.javascript.Tokens
import semmle.javascript.TypeAnnotations
import semmle.javascript.TypeScript
import semmle.javascript.Util
import semmle.javascript.Variables
import semmle.javascript.XML
import semmle.javascript.YAML
import semmle.javascript.dataflow.DataFlow
import semmle.javascript.dataflow.TaintTracking
import semmle.javascript.dataflow.TypeInference
import semmle.javascript.frameworks.Angular2
import semmle.javascript.frameworks.AngularJS
import semmle.javascript.frameworks.Anser
import semmle.javascript.frameworks.AsyncPackage
import semmle.javascript.frameworks.AWS
import semmle.javascript.frameworks.Azure
import semmle.javascript.frameworks.Babel
import semmle.javascript.frameworks.Cheerio
import semmle.javascript.frameworks.ComposedFunctions
import semmle.javascript.frameworks.Classnames
import semmle.javascript.frameworks.ClassValidator
import semmle.javascript.frameworks.ClientRequests
import semmle.javascript.frameworks.ClosureLibrary
import semmle.javascript.frameworks.CookieLibraries
import semmle.javascript.frameworks.Credentials
import semmle.javascript.frameworks.CryptoLibraries
import semmle.javascript.frameworks.D3
import semmle.javascript.frameworks.DateFunctions
import semmle.javascript.frameworks.DigitalOcean
import semmle.javascript.frameworks.Electron
import semmle.javascript.frameworks.EventEmitter
import semmle.javascript.frameworks.Files
import semmle.javascript.frameworks.Firebase
import semmle.javascript.frameworks.FormParsers
import semmle.javascript.frameworks.jQuery
import semmle.javascript.frameworks.JWT
import semmle.javascript.frameworks.Handlebars
import semmle.javascript.frameworks.Immutable
import semmle.javascript.frameworks.LazyCache
import semmle.javascript.frameworks.LodashUnderscore
import semmle.javascript.frameworks.Logging
import semmle.javascript.frameworks.HttpFrameworks
import semmle.javascript.frameworks.HttpProxy
import semmle.javascript.frameworks.Markdown
import semmle.javascript.frameworks.Nest
import semmle.javascript.frameworks.Next
import semmle.javascript.frameworks.NoSQL
import semmle.javascript.frameworks.PkgCloud
import semmle.javascript.frameworks.PropertyProjection
import semmle.javascript.frameworks.Puppeteer
import semmle.javascript.frameworks.React
import semmle.javascript.frameworks.ReactNative
import semmle.javascript.frameworks.Redux
import semmle.javascript.frameworks.Request
import semmle.javascript.frameworks.RxJS
import semmle.javascript.frameworks.ServerLess
import semmle.javascript.frameworks.ShellJS
import semmle.javascript.frameworks.SystemCommandExecutors
import semmle.javascript.frameworks.SQL
import semmle.javascript.frameworks.SocketIO
import semmle.javascript.frameworks.StringFormatters
import semmle.javascript.frameworks.TorrentLibraries
import semmle.javascript.frameworks.Typeahead
import semmle.javascript.frameworks.UriLibraries
import semmle.javascript.frameworks.Vue
import semmle.javascript.frameworks.WebSocket
import semmle.javascript.frameworks.XmlParsers
import semmle.javascript.frameworks.xUnit
import semmle.javascript.linters.ESLint
import semmle.javascript.linters.JSLint
import semmle.javascript.linters.Linting
import semmle.javascript.security.dataflow.RemoteFlowSources

class ProfileNode extends @profile_node {
  File getFile() { profile_nodes(this, _, _, "file://" + result.getAbsolutePath(), _, _, _) }

  string getFunctionName() { profile_nodes(this, result, _, _, _, _, _) }

  string getFileUri() { profile_nodes(this, _, _, result, _, _, _) }

  Location getLocation() {
    profile_nodes(this, _, _, "file://" + result.getFile().getAbsolutePath(), result.getStartLine(),
      result.getStartColumn(), _)
  }

  Function getFunction() {
    result.getLocation() = getLocation() and
    result.getName() = getFunctionName()
  }

  ProfileNode getAChild() { profile_node_children(this, result) }

  int getTicks() { profile_nodes(this, _, _, _, _, _, result) }

  int getTicks(int line) { position_ticks(this, line, result) }

  string toString() { result = "profile node" }
}

private predicate test(ProfileNode parent, string f, ProfileNode child, int line, int ticks) {
  child = parent.getAChild() and
  f = parent.getFileUri() and
  ticks = child.getTicks(line)
}

private predicate test2(ProfileNode n, File f) { f = n.getFile() }

private predicate test3(ProfileNode n, Location f) { f = n.getLocation() }
