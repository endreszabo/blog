"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _wrapRegExp(re, groups) { _wrapRegExp = function _wrapRegExp(re, groups) { return new BabelRegExp(re, undefined, groups); }; var _RegExp = _wrapNativeSuper(RegExp); var _super = RegExp.prototype; var _groups = new WeakMap(); function BabelRegExp(re, flags, groups) { var _this = _RegExp.call(this, re, flags); _groups.set(_this, groups || _groups.get(re)); return _this; } _inherits(BabelRegExp, _RegExp); BabelRegExp.prototype.exec = function (str) { var result = _super.exec.call(this, str); if (result) result.groups = buildGroups(result, this); return result; }; BabelRegExp.prototype[Symbol.replace] = function (str, substitution) { if (typeof substitution === "string") { var groups = _groups.get(this); return _super[Symbol.replace].call(this, str, substitution.replace(/\$<([^>]+)>/g, function (_, name) { return "$" + groups[name]; })); } else if (typeof substitution === "function") { var _this = this; return _super[Symbol.replace].call(this, str, function () { var args = []; args.push.apply(args, arguments); if (_typeof(args[args.length - 1]) !== "object") { args.push(buildGroups(args, _this)); } return substitution.apply(this, args); }); } else { return _super[Symbol.replace].call(this, str, substitution); } }; function buildGroups(result, re) { var g = _groups.get(re); return Object.keys(g).reduce(function (groups, name) { groups[name] = result[g[name]]; return groups; }, Object.create(null)); } return _wrapRegExp.apply(this, arguments); }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function"); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, writable: true, configurable: true } }); if (superClass) _setPrototypeOf(subClass, superClass); }

function _possibleConstructorReturn(self, call) { if (call && (_typeof(call) === "object" || typeof call === "function")) { return call; } return _assertThisInitialized(self); }

function _assertThisInitialized(self) { if (self === void 0) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return self; }

function _wrapNativeSuper(Class) { var _cache = typeof Map === "function" ? new Map() : undefined; _wrapNativeSuper = function _wrapNativeSuper(Class) { if (Class === null || !_isNativeFunction(Class)) return Class; if (typeof Class !== "function") { throw new TypeError("Super expression must either be null or a function"); } if (typeof _cache !== "undefined") { if (_cache.has(Class)) return _cache.get(Class); _cache.set(Class, Wrapper); } function Wrapper() { return _construct(Class, arguments, _getPrototypeOf(this).constructor); } Wrapper.prototype = Object.create(Class.prototype, { constructor: { value: Wrapper, enumerable: false, writable: true, configurable: true } }); return _setPrototypeOf(Wrapper, Class); }; return _wrapNativeSuper(Class); }

function isNativeReflectConstruct() { if (typeof Reflect === "undefined" || !Reflect.construct) return false; if (Reflect.construct.sham) return false; if (typeof Proxy === "function") return true; try { Date.prototype.toString.call(Reflect.construct(Date, [], function () {})); return true; } catch (e) { return false; } }

function _construct(Parent, args, Class) { if (isNativeReflectConstruct()) { _construct = Reflect.construct; } else { _construct = function _construct(Parent, args, Class) { var a = [null]; a.push.apply(a, args); var Constructor = Function.bind.apply(Parent, a); var instance = new Constructor(); if (Class) _setPrototypeOf(instance, Class.prototype); return instance; }; } return _construct.apply(null, arguments); }

function _isNativeFunction(fn) { return Function.toString.call(fn).indexOf("[native code]") !== -1; }

function _setPrototypeOf(o, p) { _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) { o.__proto__ = p; return o; }; return _setPrototypeOf(o, p); }

function _getPrototypeOf(o) { _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) { return o.__proto__ || Object.getPrototypeOf(o); }; return _getPrototypeOf(o); }

function martian_explainer(src_dom_id, dst_dom_id) {
  var ether_types = {
    '08 00': 'IPv4',
    '08 05': 'X25',
    '08 06': 'ARP',
    '08 08': 'FR_ARP',
    '08 FF': 'BPQ',
    '60 00': 'DEC',
    '60 01': 'DNA_DL',
    '60 02': 'DNA_RC',
    '60 03': 'DNA_RT',
    '60 04': 'LAT',
    '60 05': 'DIAG',
    '60 06': 'CUST',
    '60 07': 'SCA',
    '65 58': 'TEB',
    '65 59': 'RAW_FR',
    '80 35': 'RARP',
    '80 F3': 'AARP',
    '80 9B': 'ATALK',
    '81 00': '802_1Q',
    '81 37': 'IPX',
    '81 91': 'NetBEUI',
    '86 DD': 'IPv6',
    '88 0B': 'PPP',
    '88 4C': 'ATMMPOA',
    '88 63': 'PPP_DISC',
    '88 64': 'PPP_SES',
    '88 84': 'ATMFATE',
    '90 00': 'LOOP'
  };
  var html_tag = 'code';
  var a = document.getElementById(src_dom_id).value.split("\n");
  var retval = [];

  while (a.length) {
    s = a.shift();
    var rv = '';

    if (source_values = s.match(RegExp(_wrapRegExp(/martian source ([\.0-9]+) from ([\.0-9]+), on dev ([\0-\x08\x0E-\x1F!-\x9F\xA1-\u167F\u1681-\u1FFF\u200B-\u2027\u202A-\u202E\u2030-\u205E\u2060-\u2FFF\u3001-\uFEFE\uFF00-\uFFFF]+)/, {
      source_ip: 1,
      destination_ip: 2,
      dev_in: 3
    })))) {
      var source = source_values.groups.source_ip;
      var destination = source_values.groups.destination_ip;
      var ether_type = '';
      var device = source_values.groups.dev_in;
      rv += "The log item ...<br><pre>" + source_values.input;

      if (ll_values = a[0].match(RegExp(_wrapRegExp(/ll header:(?: 0{8}:)? ((?:[0-9a-f]{2}[ :]){5}[0-9a-f]{2})[ :]((?:[0-9a-f]{2}[ :]){5}[0-9a-f]{2})[ :]([0-9a-f]{2}[ :][0-9a-f]{2})/, {
        mac_dst: 1,
        mac_src: 2,
        ether_type: 3
      })))) {
        source += ' (' + ll_values.groups.mac_src.split(' ').join(':') + ')';
        destination += ' (' + ll_values.groups.mac_dst.split(' ').join(':') + ')';
        ether_type = ether_types[ll_values.groups.ether_type.replace(':', '')];
        a.shift();
        rv += '<br>' + ll_values.input;
      }

      rv += "</pre>... means that a packet ";
      if (ether_type) rv += "type of <" + html_tag + ">" + ether_type + "</" + html_tag + "> ";
      rv += "has arrived ";
      if (device) rv += "on the inbound interface <" + html_tag + ">" + device + "</" + html_tag + "> ";
      rv += "from network host <" + html_tag + ">" + source + "</" + html_tag + "> ";
      rv += "destined to <" + html_tag + ">" + destination + "</" + html_tag + "> ";
      rv += "but it's coming from an <i>IP address/interface combination</i> that the kernel didn't expect. ";
      rv += "(The kernel would expect packet coming from " + source_values.groups.source_ip + " on an interface different than " + device + ". Please revisit the routing table on the host logging the martian messages and/or fix the IP address of the source host.)";
    } else if (destination_values = s.match(RegExp(_wrapRegExp(/martian destination ([\.0-9]+) from ([\.0-9]+), (?:on )?dev ([\0-\x08\x0E-\x1F!-\x9F\xA1-\u167F\u1681-\u1FFF\u200B-\u2027\u202A-\u202E\u2030-\u205E\u2060-\u2FFF\u3001-\uFEFE\uFF00-\uFFFF]+)/, {
      destination_ip: 1,
      source_ip: 2,
      dev_in: 3
    })))) {
      rv += "The log item ...<br><pre>" + destination_values.input;
      rv += "</pre>... means that a packet ";
      rv += "has arrived ";
      if (destination_values.groups.dev_in) rv += "on the inbound interface <" + html_tag + ">" + destination_values.groups.dev_in + "</" + html_tag + "> ";
      rv += "from network host <" + html_tag + ">" + destination_values.groups.source_ip + "</" + html_tag + "> ";
      rv += "destined to the invalid IP address of <" + html_tag + ">" + destination_values.groups.destination_ip + "</" + html_tag + "> ";
      rv += "that can not be routed. ";
      rv += "(According the Internet standards, the routing of the packet to the destination IP address " + destination_values.groups.destination_ip + " is not possible. Please revisit the applications running on the source host " + destination_values.groups.source_in + " to avoid sending traffic to void destinations.)";
    }

    if (rv.length) retval.push("<p>" + rv + "<p>");
  }

  document.getElementById(dst_dom_id).innerHTML = retval.join("\n");
  return 1;
}