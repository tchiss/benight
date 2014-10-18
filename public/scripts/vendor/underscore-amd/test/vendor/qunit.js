/**
 * QUnit v1.12.0 - A JavaScript Unit Testing Framework
 *
 * http://qunitjs.com
 *
 * Copyright 2013 jQuery Foundation and other contributors
 * Released under the MIT license.
 * https://jquery.org/license/
 */

/**
 * jsDump Copyright (c) 2008 Ariel Flesler - aflesler(at)gmail(dot)com |
 * http://flesler.blogspot.com Licensed under BSD
 * (http://www.opensource.org/licenses/bsd-license.php) Date: 5/15/2008
 *
 * @projectDescription Advanced and extensible data dumping for Javascript.
 * @version 1.0.0
 * @author Ariel Flesler
 * @link {http://flesler.blogspot.com/2008/05/jsdump-pretty-dump-of-any-javascript.html}
 */

/*
 * Javascript Diff Algorithm
 *  By John Resig (http://ejohn.org/)
 *  Modified by Chu Alan "sprite"
 *
 * Released under the MIT license.
 *
 * More Info:
 *  http://ejohn.org/projects/javascript-diff-algorithm/
 *
 * Usage: QUnit.diff(expected, actual)
 *
 * QUnit.diff( "the quick brown fox jumped over", "the quick fox jumps over" ) == "the  quick <del>brown </del> fox <del>jumped </del><ins>jumps </ins> over"
 */

(function(e){function d(e){N(this,e),this.assertions=[],this.testNumber=++d.count}function v(){r.autorun=!0,r.currentModule&&D("moduleDone",t,{name:r.currentModule,failed:r.moduleStats.bad,passed:r.moduleStats.all-r.moduleStats.bad,total:r.moduleStats.all}),delete r.previousModule;var n,i,s=M("qunit-banner"),o=M("qunit-tests"),u=+(new f)-r.started,a=r.stats.all-r.stats.bad,l=["Tests completed in ",u," milliseconds.<br/>","<span class='passed'>",a,"</span> assertions of <span class='total'>",r.stats.all,"</span> passed, <span class='failed'>",r.stats.bad,"</span> failed."].join("");s&&(s.className=r.stats.bad?"qunit-fail":"qunit-pass"),o&&(M("qunit-testresult").innerHTML=l),r.altertitle&&typeof document!="undefined"&&document.title&&(document.title=[r.stats.bad?"✖":"✔",document.title.replace(/^[\u2714\u2716] /i,"")].join(" "));if(r.reorder&&c.sessionStorage&&r.stats.bad===0)for(n=0;n<sessionStorage.length;n++)i=sessionStorage.key(n++),i.indexOf("qunit-test-")===0&&sessionStorage.removeItem(i);e.scrollTo&&e.scrollTo(0,0),D("done",t,{failed:r.stats.bad,passed:a,total:r.stats.all,runtime:u})}function m(e){var t,n=r.filter&&r.filter.toLowerCase(),i=r.module&&r.module.toLowerCase(),s=(e.module+": "+e.testName).toLowerCase();return e.callback&&e.callback.validTest===m?(delete e.callback.validTest,!0):r.testNumber?e.testNumber===r.testNumber:i&&(!e.module||e.module.toLowerCase()!==i)?!1:n?(t=n.charAt(0)!=="!",t||(n=n.slice(1)),s.indexOf(n)!==-1?t:!t):!0}function g(e,t){t=t===undefined?3:t;var n,r,i;if(e.stacktrace)return e.stacktrace.split("\n")[t+3];if(e.stack){n=e.stack.split("\n"),/^error$/i.test(n[0])&&n.shift();if(o){r=[];for(i=t;i<n.length;i++){if(n[i].indexOf(o)!==-1)break;r.push(n[i])}if(r.length)return r.join("\n")}return n[t]}if(e.sourceURL){if(/qunit.js$/.test(e.sourceURL))return;return e.sourceURL+":"+e.line}}function y(e){try{throw new Error}catch(t){return g(t,e)}}function b(e){return e?(e+="",e.replace(/['"<>&]/g,function(e){switch(e){case"'":return"&#039;";case'"':return"&quot;";case"<":return"&lt;";case">":return"&gt;";case"&":return"&amp;"}})):""}function w(e,t){r.queue.push(e),r.autorun&&!r.blocking&&E(t)}function E(e){function t(){E(e)}var n=(new f).getTime();r.depth=r.depth?r.depth+1:1;while(r.queue.length&&!r.blocking){if(!(!c.setTimeout||r.updateRate<=0||(new f).getTime()-n<r.updateRate)){l(t,13);break}r.queue.shift()()}r.depth--,e&&!r.blocking&&!r.queue.length&&r.depth===0&&v()}function S(){r.pollution=[];if(r.noglobals)for(var t in e)if(a.call(e,t)){if(/^qunit-test-output/.test(t))continue;r.pollution.push(t)}}function x(){var e,n,i=r.pollution;S(),e=T(r.pollution,i),e.length>0&&t.pushFailure("Introduced global variable(s): "+e.join(", ")),n=T(i,r.pollution),n.length>0&&t.pushFailure("Deleted global variable(s): "+n.join(", "))}function T(e,t){var n,r,i=e.slice();for(n=0;n<i.length;n++)for(r=0;r<t.length;r++)if(i[n]===t[r]){i.splice(n,1),n--;break}return i}function N(t,n){for(var r in n)a.call(n,r)&&(r!=="constructor"||t!==e)&&(n[r]===undefined?delete t[r]:t[r]=n[r]);return t}function C(e,t,n){e.addEventListener?e.addEventListener(t,n,!1):e.attachEvent("on"+t,n)}function k(e,t,n){var r=e.length;while(r--)C(e[r],t,n)}function L(e,t){return(" "+e.className+" ").indexOf(" "+t+" ")>-1}function A(e,t){L(e,t)||(e.className+=(e.className?" ":"")+t)}function O(e,t){var n=" "+e.className+" ";while(n.indexOf(" "+t+" ")>-1)n=n.replace(" "+t+" "," ");e.className=typeof n.trim=="function"?n.trim():n.replace(/^\s+|\s+$/g,"")}function M(e){return typeof document!="undefined"&&!!document&&!!document.getElementById&&document.getElementById(e)}function _(e){return function(t){r[e].push(t)}}function D(e,n,i){var s,o;if(t.hasOwnProperty(e))t[e].call(n,i);else{o=r[e];for(s=0;s<o.length;s++)o[s].call(n,i)}}function P(e,t){if(t.indexOf)return t.indexOf(e);for(var n=0,r=t.length;n<r;n++)if(t[n]===e)return n;return-1}var t,n,r,i,s=0,o=(y(0)||"").replace(/(:\d+)+\)?/,"").replace(/.+\//,""),u=Object.prototype.toString,a=Object.prototype.hasOwnProperty,f=e.Date,l=e.setTimeout,c={setTimeout:typeof e.setTimeout!="undefined",sessionStorage:function(){var e="qunit-test-string";try{return sessionStorage.setItem(e,e),sessionStorage.removeItem(e),!0}catch(t){return!1}}()},h=function(e){var t,n,r=e.toString();return r.substring(0,7)==="[object"?(t=e.name?e.name.toString():"Error",n=e.message?e.message.toString():"",t&&n?t+": "+n:t?t:n?n:"Error"):r},p=function(e){var n,r,i=t.is("array",e)?[]:{};for(n in e)a.call(e,n)&&(r=e[n],i[n]=r===Object(r)?p(r):r);return i};d.count=0,d.prototype={init:function(){var e,n,r,i=M("qunit-tests");i&&(n=document.createElement("strong"),n.innerHTML=this.nameHtml,e=document.createElement("a"),e.innerHTML="Rerun",e.href=t.url({testNumber:this.testNumber}),r=document.createElement("li"),r.appendChild(n),r.appendChild(e),r.className="running",r.id=this.id="qunit-test-output"+s++,i.appendChild(r))},setup:function(){if(this.module!==r.previousModule||!a.call(r,"previousModule"))a.call(r,"previousModule")&&D("moduleDone",t,{name:r.previousModule,failed:r.moduleStats.bad,passed:r.moduleStats.all-r.moduleStats.bad,total:r.moduleStats.all}),r.previousModule=this.module,r.moduleStats={all:0,bad:0},D("moduleStart",t,{name:this.module});r.current=this,this.testEnvironment=N({setup:function(){},teardown:function(){}},this.moduleTestEnvironment),this.started=+(new f),D("testStart",t,{name:this.testName,module:this.module}),t.current_testEnvironment=this.testEnvironment,r.pollution||S();if(r.notrycatch){this.testEnvironment.setup.call(this.testEnvironment,t.assert);return}try{this.testEnvironment.setup.call(this.testEnvironment,t.assert)}catch(e){t.pushFailure("Setup failed on "+this.testName+": "+(e.message||e),g(e,1))}},run:function(){r.current=this;var e=M("qunit-testresult");e&&(e.innerHTML="Running: <br/>"+this.nameHtml),this.async&&t.stop(),this.callbackStarted=+(new f);if(r.notrycatch){this.callback.call(this.testEnvironment,t.assert),this.callbackRuntime=+(new f)-this.callbackStarted;return}try{this.callback.call(this.testEnvironment,t.assert),this.callbackRuntime=+(new f)-this.callbackStarted}catch(n){this.callbackRuntime=+(new f)-this.callbackStarted,t.pushFailure("Died on test #"+(this.assertions.length+1)+" "+this.stack+": "+(n.message||n),g(n,0)),S(),r.blocking&&t.start()}},teardown:function(){r.current=this;if(r.notrycatch){typeof this.callbackRuntime=="undefined"&&(this.callbackRuntime=+(new f)-this.callbackStarted),this.testEnvironment.teardown.call(this.testEnvironment,t.assert);return}try{this.testEnvironment.teardown.call(this.testEnvironment,t.assert)}catch(e){t.pushFailure("Teardown failed on "+this.testName+": "+(e.message||e),g(e,1))}x()},finish:function(){r.current=this,r.requireExpects&&this.expected===null?t.pushFailure("Expected number of assertions to be defined, but expect() was not called.",this.stack):this.expected!==null&&this.expected!==this.assertions.length?t.pushFailure("Expected "+this.expected+" assertions, but "+this.assertions.length+" were run",this.stack):this.expected===null&&!this.assertions.length&&t.pushFailure("Expected at least one assertion, but none were run - call expect(0) to accept zero assertions.",this.stack);var n,i,s,o,u,a,l,h=this,p=0,d=0,v=M("qunit-tests");this.runtime=+(new f)-this.started,r.stats.all+=this.assertions.length,r.moduleStats.all+=this.assertions.length;if(v){l=document.createElement("ol"),l.className="qunit-assert-list";for(n=0;n<this.assertions.length;n++)i=this.assertions[n],a=document.createElement("li"),a.className=i.result?"pass":"fail",a.innerHTML=i.message||(i.result?"okay":"failed"),l.appendChild(a),i.result?p++:(d++,r.stats.bad++,r.moduleStats.bad++);t.config.reorder&&c.sessionStorage&&(d?sessionStorage.setItem("qunit-test-"+this.module+"-"+this.testName,d):sessionStorage.removeItem("qunit-test-"+this.module+"-"+this.testName)),d===0&&A(l,"qunit-collapsed"),o=document.createElement("strong"),o.innerHTML=this.nameHtml+" <b class='counts'>(<b class='failed'>"+d+"</b>, <b class='passed'>"+p+"</b>, "+this.assertions.length+")</b>",C(o,"click",function(){var e=o.parentNode.lastChild,t=L(e,"qunit-collapsed");(t?O:A)(e,"qunit-collapsed")}),C(o,"dblclick",function(n){var r=n&&n.target?n.target:e.event.srcElement;if(r.nodeName.toLowerCase()==="span"||r.nodeName.toLowerCase()==="b")r=r.parentNode;e.location&&r.nodeName.toLowerCase()==="strong"&&(e.location=t.url({testNumber:h.testNumber}))}),u=document.createElement("span"),u.className="runtime",u.innerHTML=this.runtime+" ms",a=M(this.id),a.className=d?"fail":"pass",a.removeChild(a.firstChild),s=a.firstChild,a.appendChild(o),a.appendChild(s),a.appendChild(u),a.appendChild(l)}else for(n=0;n<this.assertions.length;n++)this.assertions[n].result||(d++,r.stats.bad++,r.moduleStats.bad++);D("testDone",t,{name:this.testName,module:this.module,failed:d,passed:this.assertions.length-d,total:this.assertions.length,duration:this.runtime}),t.reset(),r.current=undefined},queue:function(){function r(){w(function(){n.setup()}),w(function(){n.run()}),w(function(){n.teardown()}),w(function(){n.finish()})}var e,n=this;w(function(){n.init()}),e=t.config.reorder&&c.sessionStorage&&+sessionStorage.getItem("qunit-test-"+this.module+"-"+this.testName),e?r():w(r,!0)}},t={module:function(e,t){r.currentModule=e,r.currentModuleTestEnvironment=t,r.modules[e]=!0},asyncTest:function(e,n,r){arguments.length===2&&(r=n,n=null),t.test(e,n,r,!0)},test:function(e,t,n,i){var s,o="<span class='test-name'>"+b(e)+"</span>";arguments.length===2&&(n=t,t=null),r.currentModule&&(o="<span class='module-name'>"+b(r.currentModule)+"</span>: "+o),s=new d({nameHtml:o,testName:e,expected:t,async:i,callback:n,module:r.currentModule,moduleTestEnvironment:r.currentModuleTestEnvironment,stack:y(2)});if(!m(s))return;s.queue()},expect:function(e){if(arguments.length!==1)return r.current.expected;r.current.expected=e},start:function(e){if(r.semaphore===undefined){t.begin(function(){l(function(){t.start(e)})});return}r.semaphore-=e||1;if(r.semaphore>0)return;if(r.semaphore<0){r.semaphore=0,t.pushFailure("Called start() while already started (QUnit.config.semaphore was 0 already)",null,y(2));return}c.setTimeout?l(function(){if(r.semaphore>0)return;r.timeout&&clearTimeout(r.timeout),r.blocking=!1,E(!0)},13):(r.blocking=!1,E(!0))},stop:function(e){r.semaphore+=e||1,r.blocking=!0,r.testTimeout&&c.setTimeout&&(clearTimeout(r.timeout),r.timeout=l(function(){t.ok(!1,"Test timed out"),r.semaphore=1,t.start()},r.testTimeout))}},n={ok:function(e,n){if(!r.current)throw new Error("ok() assertion outside test context, was "+y(2));e=!!e,n=n||(e?"okay":"failed");var i,s={module:r.current.module,name:r.current.testName,result:e,message:n};n="<span class='test-message'>"+b(n)+"</span>",e||(i=y(2),i&&(s.source=i,n+="<table><tr class='test-source'><th>Source: </th><td><pre>"+b(i)+"</pre></td></tr></table>")),D("log",t,s),r.current.assertions.push({result:e,message:n})},equal:function(e,n,r){t.push(n==e,e,n,r)},notEqual:function(e,n,r){t.push(n!=e,e,n,r)},propEqual:function(e,n,r){e=p(e),n=p(n),t.push(t.equiv(e,n),e,n,r)},notPropEqual:function(e,n,r){e=p(e),n=p(n),t.push(!t.equiv(e,n),e,n,r)},deepEqual:function(e,n,r){t.push(t.equiv(e,n),e,n,r)},notDeepEqual:function(e,n,r){t.push(!t.equiv(e,n),e,n,r)},strictEqual:function(e,n,r){t.push(n===e,e,n,r)},notStrictEqual:function(e,n,r){t.push(n!==e,e,n,r)},"throws":function(e,n,i){var s,o=n,u=!1;typeof n=="string"&&(i=n,n=null),r.current.ignoreGlobalErrors=!0;try{e.call(r.current.testEnvironment)}catch(a){s=a}r.current.ignoreGlobalErrors=!1,s?(n?t.objectType(n)==="regexp"?u=n.test(h(s)):s instanceof n?u=!0:n.call({},s)===!0&&(o=null,u=!0):(u=!0,o=null),t.push(u,s,o,i)):t.pushFailure(i,null,"No exception was thrown.")}},N(t,n),t.raises=n["throws"],t.equals=function(){t.push(!1,!1,!1,"QUnit.equals has been deprecated since 2009 (e88049a0), use QUnit.equal instead")},t.same=function(){t.push(!1,!1,!1,"QUnit.same has been deprecated since 2009 (e88049a0), use QUnit.deepEqual instead")},function(){function e(){}e.prototype=t,t=new e,t.constructor=e}(),r={queue:[],blocking:!0,hidepassed:!1,reorder:!0,altertitle:!0,requireExpects:!1,urlConfig:[{id:"noglobals",label:"Check for Globals",tooltip:"Enabling this will test if any test introduces new properties on the `window` object. Stored as query-strings."},{id:"notrycatch",label:"No try-catch",tooltip:"Enabling this will run tests outside of a try-catch block. Makes debugging exceptions in IE reasonable. Stored as query-strings."}],modules:{},begin:[],done:[],log:[],testStart:[],testDone:[],moduleStart:[],moduleDone:[]},typeof exports=="undefined"&&(N(e,t.constructor.prototype),e.QUnit=t),function(){var n,i=e.location||{search:"",protocol:"file:"},s=i.search.slice(1).split("&"),o=s.length,u={},a;if(s[0])for(n=0;n<o;n++)a=s[n].split("="),a[0]=decodeURIComponent(a[0]),a[1]=a[1]?decodeURIComponent(a[1]):!0,u[a[0]]=a[1];t.urlParams=u,r.filter=u.filter,r.module=u.module,r.testNumber=parseInt(u.testNumber,10)||null,t.isLocal=i.protocol==="file:"}(),N(t,{assert:n,config:r,init:function(){N(r,{stats:{all:0,bad:0},moduleStats:{all:0,bad:0},started:+(new f),updateRate:1e3,blocking:!1,autostart:!0,autorun:!1,filter:"",queue:[],semaphore:1});var e,t,n,i=M("qunit");i&&(i.innerHTML="<h1 id='qunit-header'>"+b(document.title)+"</h1>"+"<h2 id='qunit-banner'></h2>"+"<div id='qunit-testrunner-toolbar'></div>"+"<h2 id='qunit-userAgent'></h2>"+"<ol id='qunit-tests'></ol>"),e=M("qunit-tests"),t=M("qunit-banner"),n=M("qunit-testresult"),e&&(e.innerHTML=""),t&&(t.className=""),n&&n.parentNode.removeChild(n),e&&(n=document.createElement("p"),n.id="qunit-testresult",n.className="result",e.parentNode.insertBefore(n,e),n.innerHTML="Running...<br/>&nbsp;")},reset:function(){var e=M("qunit-fixture");e&&(e.innerHTML=r.fixture)},triggerEvent:function(e,t,n){document.createEvent?(n=document.createEvent("MouseEvents"),n.initMouseEvent(t,!0,!0,e.ownerDocument.defaultView,0,0,0,0,0,!1,!1,!1,!1,0,null),e.dispatchEvent(n)):e.fireEvent&&e.fireEvent("on"+t)},is:function(e,n){return t.objectType(n)===e},objectType:function(e){if(typeof e=="undefined")return"undefined";if(e===null)return"null";var t=u.call(e).match(/^\[object\s(.*)\]$/),n=t&&t[1]||"";switch(n){case"Number":if(isNaN(e))return"nan";return"number";case"String":case"Boolean":case"Array":case"Date":case"RegExp":case"Function":return n.toLowerCase()}return typeof e=="object"?"object":undefined},push:function(e,n,i,s){if(!r.current)throw new Error("assertion outside test context, was "+y());var o,u,a={module:r.current.module,name:r.current.testName,result:e,message:s,actual:n,expected:i};s=b(s)||(e?"okay":"failed"),s="<span class='test-message'>"+s+"</span>",o=s,e||(i=b(t.jsDump.parse(i)),n=b(t.jsDump.parse(n)),o+="<table><tr class='test-expected'><th>Expected: </th><td><pre>"+i+"</pre></td></tr>",n!==i&&(o+="<tr class='test-actual'><th>Result: </th><td><pre>"+n+"</pre></td></tr>",o+="<tr class='test-diff'><th>Diff: </th><td><pre>"+t.diff(i,n)+"</pre></td></tr>"),u=y(),u&&(a.source=u,o+="<tr class='test-source'><th>Source: </th><td><pre>"+b(u)+"</pre></td></tr>"),o+="</table>"),D("log",t,a),r.current.assertions.push({result:!!e,message:o})},pushFailure:function(e,n,i){if(!r.current)throw new Error("pushFailure() assertion outside test context, was "+y(2));var s,o={module:r.current.module,name:r.current.testName,result:!1,message:e};e=b(e)||"error",e="<span class='test-message'>"+e+"</span>",s=e,s+="<table>",i&&(s+="<tr class='test-actual'><th>Result: </th><td><pre>"+b(i)+"</pre></td></tr>"),n&&(o.source=n,s+="<tr class='test-source'><th>Source: </th><td><pre>"+b(n)+"</pre></td></tr>"),s+="</table>",D("log",t,o),r.current.assertions.push({result:!1,message:s})},url:function(n){n=N(N({},t.urlParams),n);var r,i="?";for(r in n)a.call(n,r)&&(i+=encodeURIComponent(r)+"="+encodeURIComponent(n[r])+"&");return e.location.protocol+"//"+e.location.host+e.location.pathname+i.slice(0,-1)},extend:N,id:M,addEvent:C,addClass:A,hasClass:L,removeClass:O}),N(t.constructor.prototype,{begin:_("begin"),done:_("done"),log:_("log"),testStart:_("testStart"),testDone:_("testDone"),moduleStart:_("moduleStart"),moduleDone:_("moduleDone")});if(typeof document=="undefined"||document.readyState==="complete")r.autorun=!0;t.load=function(){D("begin",t,{});var n,i,s,o,u,a,f,l,h,p,d,v,m,g=0,y=[],w="",E="",S=N({},r);t.init(),N(r,S),r.blocking=!1,u=r.urlConfig.length;for(s=0;s<u;s++)p=r.urlConfig[s],typeof p=="string"&&(p={id:p,label:p,tooltip:"[no tooltip available]"}),r[p.id]=t.urlParams[p.id],E+="<input id='qunit-urlconfig-"+b(p.id)+"' name='"+b(p.id)+"' type='checkbox'"+(r[p.id]?" checked='checked'":"")+" title='"+b(p.tooltip)+"'><label for='qunit-urlconfig-"+b(p.id)+"' title='"+b(p.tooltip)+"'>"+p.label+"</label>";for(s in r.modules)r.modules.hasOwnProperty(s)&&y.push(s);g=y.length,y.sort(function(e,t){return e.localeCompare(t)}),w+="<label for='qunit-modulefilter'>Module: </label><select id='qunit-modulefilter' name='modulefilter'><option value='' "+(r.module===undefined?"selected='selected'":"")+">< All Modules ></option>";for(s=0;s<g;s++)w+="<option value='"+b(encodeURIComponent(y[s]))+"' "+(r.module===y[s]?"selected='selected'":"")+">"+b(y[s])+"</option>";w+="</select>",h=M("qunit-userAgent"),h&&(h.innerHTML=navigator.userAgent),n=M("qunit-header"),n&&(n.innerHTML="<a href='"+t.url({filter:undefined,module:undefined,testNumber:undefined})+"'>"+n.innerHTML+"</a> "),l=M("qunit-testrunner-toolbar");if(l){i=document.createElement("input"),i.type="checkbox",i.id="qunit-filter-pass",C(i,"click",function(){var e,t=document.getElementById("qunit-tests");i.checked?t.className=t.className+" hidepass":(e=" "+t.className.replace(/[\n\t\r]/g," ")+" ",t.className=e.replace(/ hidepass /," ")),c.sessionStorage&&(i.checked?sessionStorage.setItem("qunit-filter-passed-tests","true"):sessionStorage.removeItem("qunit-filter-passed-tests"))});if(r.hidepassed||c.sessionStorage&&sessionStorage.getItem("qunit-filter-passed-tests"))i.checked=!0,f=document.getElementById("qunit-tests"),f.className=f.className+" hidepass";l.appendChild(i),o=document.createElement("label"),o.setAttribute("for","qunit-filter-pass"),o.setAttribute("title","Only show tests and assertions that fail. Stored in sessionStorage."),o.innerHTML="Hide passed tests",l.appendChild(o),d=document.createElement("span"),d.innerHTML=E,v=d.getElementsByTagName("input"),k(v,"click",function(n){var r={},i=n.target||n.srcElement;r[i.name]=i.checked?!0:undefined,e.location=t.url(r)}),l.appendChild(d),g>1&&(m=document.createElement("span"),m.setAttribute("id","qunit-modulefilter-container"),m.innerHTML=w,C(m.lastChild,"change",function(){var n=m.getElementsByTagName("select")[0],r=decodeURIComponent(n.options[n.selectedIndex].value);e.location=t.url({module:r===""?undefined:r,filter:undefined,testNumber:undefined})}),l.appendChild(m))}a=M("qunit-fixture"),a&&(r.fixture=a.innerHTML),r.autostart&&t.start()},C(e,"load",t.load),i=e.onerror,e.onerror=function(e,n,r){var s=!1;i&&(s=i(e,n,r));if(s!==!0){if(t.config.current){if(t.config.current.ignoreGlobalErrors)return!0;t.pushFailure(e,n+":"+r)}else t.test("global failure",N(function(){t.pushFailure(e,n+":"+r)},{validTest:m}));return!1}return s},t.equiv=function(){function e(e,n,r){var i=t.objectType(e);if(i)return t.objectType(n[i])==="function"?n[i].apply(n,r):n[i]}var n,r=[],i=[],s=[],o=Object.getPrototypeOf||function(e){return e.__proto__},u=function(){function e(e,t){return e instanceof t.constructor||t instanceof e.constructor?t==e:t===e}return{string:e,"boolean":e,number:e,"null":e,"undefined":e,nan:function(e){return isNaN(e)},date:function(e,n){return t.objectType(e)==="date"&&n.valueOf()===e.valueOf()},regexp:function(e,n){return t.objectType(e)==="regexp"&&n.source===e.source&&n.global===e.global&&n.ignoreCase===e.ignoreCase&&n.multiline===e.multiline&&n.sticky===e.sticky},"function":function(){var e=r[r.length-1];return e!==Object&&typeof e!="undefined"},array:function(e,r){var o,u,a,f,l,c;if(t.objectType(e)!=="array")return!1;a=r.length;if(a!==e.length)return!1;i.push(r),s.push(e);for(o=0;o<a;o++){f=!1;for(u=0;u<i.length;u++){l=i[u]===r[o],c=s[u]===e[o];if(l||c){if(!(r[o]===e[o]||l&&c))return i.pop(),s.pop(),!1;f=!0}}if(!f&&!n(r[o],e[o]))return i.pop(),s.pop(),!1}return i.pop(),s.pop(),!0},object:function(e,t){var u,a,f,l,c,h=!0,p=[],d=[];if(t.constructor===e.constructor||o(t)===null&&o(e)===Object.prototype||o(e)===null&&o(t)===Object.prototype){r.push(t.constructor),i.push(t),s.push(e);for(u in t){f=!1;for(a=0;a<i.length;a++){l=i[a]===t[u],c=s[a]===e[u];if(l||c){if(!(t[u]===e[u]||l&&c)){h=!1;break}f=!0}}p.push(u);if(!f&&!n(t[u],e[u])){h=!1;break}}i.pop(),s.pop(),r.pop();for(u in e)d.push(u);return h&&n(p.sort(),d.sort())}return!1}}}();return n=function(){var r=[].slice.apply(arguments);return r.length<2?!0:function(n,r){return n===r?!0:n===null||r===null||typeof n=="undefined"||typeof r=="undefined"||t.objectType(n)!==t.objectType(r)?!1:e(n,u,[r,n])}(r[0],r[1])&&n.apply(this,r.splice(1,r.length-1))},n}(),t.jsDump=function(){function e(e){return'"'+e.toString().replace(/"/g,'\\"')+'"'}function n(e){return e+""}function r(e,t,n){var r=o.separator(),i=o.indent(),s=o.indent(1);return t.join&&(t=t.join(","+r+s)),t?[e,s+t,i+n].join(r):e+n}function i(e,t){var n=e.length,i=new Array(n);this.up();while(n--)i[n]=this.parse(e[n],undefined,t);return this.down(),r("[",i,"]")}var s=/^function (\w+)/,o={parse:function(e,t,n){n=n||[];var r,i,s=this.parsers[t||this.typeOf(e)];return t=typeof s,r=P(e,n),r!==-1?"recursion("+(r-n.length)+")":t==="function"?(n.push(e),i=s.call(this,e,n),n.pop(),i):t==="string"?s:this.parsers.error},typeOf:function(e){var n;return e===null?n="null":typeof e=="undefined"?n="undefined":t.is("regexp",e)?n="regexp":t.is("date",e)?n="date":t.is("function",e)?n="function":typeof e.setInterval!==undefined&&typeof e.document!="undefined"&&typeof e.nodeType=="undefined"?n="window":e.nodeType===9?n="document":e.nodeType?n="node":u.call(e)==="[object Array]"||typeof e.length=="number"&&typeof e.item!="undefined"&&(e.length?e.item(0)===e[0]:e.item(0)===null&&typeof e[0]=="undefined")?n="array":e.constructor===Error.prototype.constructor?n="error":n=typeof e,n},separator:function(){return this.multiline?this.HTML?"<br />":"\n":this.HTML?"&nbsp;":" "},indent:function(e){if(!this.multiline)return"";var t=this.indentChar;return this.HTML&&(t=t.replace(/\t/g,"   ").replace(/ /g,"&nbsp;")),(new Array(this.depth+(e||0))).join(t)},up:function(e){this.depth+=e||1},down:function(e){this.depth-=e||1},setParser:function(e,t){this.parsers[e]=t},quote:e,literal:n,join:r,depth:1,parsers:{window:"[Window]",document:"[Document]",error:function(e){return'Error("'+e.message+'")'},unknown:"[Unknown]","null":"null","undefined":"undefined","function":function(e){var n="function",i="name"in e?e.name:(s.exec(e)||[])[1];return i&&(n+=" "+i),n+="( ",n=[n,t.jsDump.parse(e,"functionArgs"),"){"].join(""),r(n,t.jsDump.parse(e,"functionCode"),"}")},array:i,nodelist:i,arguments:i,object:function(e,n){var i=[],s,o,u,a;t.jsDump.up(),s=[];for(o in e)s.push(o);s.sort();for(a=0;a<s.length;a++)o=s[a],u=e[o],i.push(t.jsDump.parse(o,"key")+": "+t.jsDump.parse(u,undefined,n));return t.jsDump.down(),r("{",i,"}")},node:function(e){var n,r,i,s=t.jsDump.HTML?"&lt;":"<",o=t.jsDump.HTML?"&gt;":">",u=e.nodeName.toLowerCase(),a=s+u,f=e.attributes;if(f)for(r=0,n=f.length;r<n;r++)i=f[r].nodeValue,i&&i!=="inherit"&&(a+=" "+f[r].nodeName+"="+t.jsDump.parse(i,"attribute"));a+=o;if(e.nodeType===3||e.nodeType===4)a+=e.nodeValue;return a+s+"/"+u+o},functionArgs:function(e){var t,n=e.length;if(!n)return"";t=new Array(n);while(n--)t[n]=String.fromCharCode(97+n);return" "+t.join(", ")+" "},key:e,functionCode:"[code]",attribute:e,string:e,date:e,regexp:n,number:n,"boolean":n},HTML:!1,indentChar:"  ",multiline:!0};return o}(),t.diff=function(){function e(e,t){var n,r={},i={};for(n=0;n<t.length;n++)a.call(r,t[n])||(r[t[n]]={rows:[],o:null}),r[t[n]].rows.push(n);for(n=0;n<e.length;n++)a.call(i,e[n])||(i[e[n]]={rows:[],n:null}),i[e[n]].rows.push(n);for(n in r)a.call(r,n)&&r[n].rows.length===1&&a.call(i,n)&&i[n].rows.length===1&&(t[r[n].rows[0]]={text:t[r[n].rows[0]],row:i[n].rows[0]},e[i[n].rows[0]]={text:e[i[n].rows[0]],row:r[n].rows[0]});for(n=0;n<t.length-1;n++)t[n].text!=null&&t[n+1].text==null&&t[n].row+1<e.length&&e[t[n].row+1].text==null&&t[n+1]==e[t[n].row+1]&&(t[n+1]={text:t[n+1],row:t[n].row+1},e[t[n].row+1]={text:e[t[n].row+1],row:n+1});for(n=t.length-1;n>0;n--)t[n].text!=null&&t[n-1].text==null&&t[n].row>0&&e[t[n].row-1].text==null&&t[n-1]==e[t[n].row-1]&&(t[n-1]={text:t[n-1],row:t[n].row-1},e[t[n].row-1]={text:e[t[n].row-1],row:n-1});return{o:e,n:t}}return function(t,n){t=t.replace(/\s+$/,""),n=n.replace(/\s+$/,"");var r,i,s="",o=e(t===""?[]:t.split(/\s+/),n===""?[]:n.split(/\s+/)),u=t.match(/\s+/g),a=n.match(/\s+/g);u==null?u=[" "]:u.push(" "),a==null?a=[" "]:a.push(" ");if(o.n.length===0)for(r=0;r<o.o.length;r++)s+="<del>"+o.o[r]+u[r]+"</del>";else{if(o.n[0].text==null)for(n=0;n<o.o.length&&o.o[n].text==null;n++)s+="<del>"+o.o[n]+u[n]+"</del>";for(r=0;r<o.n.length;r++)if(o.n[r].text==null)s+="<ins>"+o.n[r]+a[r]+"</ins>";else{i="";for(n=o.n[r].row+1;n<o.o.length&&o.o[n].text==null;n++)i+="<del>"+o.o[n]+u[n]+"</del>";s+=" "+o.n[r].text+a[r]+i}}return s}}(),typeof exports!="undefined"&&N(exports,t.constructor.prototype)})(function(){return this}.call());