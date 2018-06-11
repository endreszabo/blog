function martian_explainer(src_dom_id, dst_dom_id) {
	const ether_types={
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
		'90 00': 'LOOP',
	};
	const html_tag='code';
	const a=document.getElementById(src_dom_id).value.split("\n");
	let retval=[];
	while(a.length) {
		s=a.shift();
		let rv='';
		if(source_values=s.match(RegExp(/martian source (?<source_ip>[0-9\.]+) from (?<destination_ip>[0-9\.]+), on dev (?<dev_in>\S+)/))) {
			let source = source_values.groups.source_ip;
			let destination = source_values.groups.destination_ip;
			let ether_type='';
			let device=source_values.groups.dev_in;
			rv+="The log item ...<br><pre>"+source_values.input;
			if(ll_values=a[0].match(RegExp(/ll header:(?: 0{8}:)? (?<mac_dst>(?:[0-9a-f]{2}[ :]){5}[0-9a-f]{2})[ :](?<mac_src>(?:[0-9a-f]{2}[ :]){5}[0-9a-f]{2})[ :](?<ether_type>[0-9a-f]{2}[ :][0-9a-f]{2})/))) {
				source+=' ('+ll_values.groups.mac_src.split(' ').join(':')+')';
				destination+=' ('+ll_values.groups.mac_dst.split(' ').join(':')+')';
				ether_type=ether_types[ll_values.groups.ether_type.replace(':','')];
				a.shift();
				rv+='<br>'+ll_values.input;
			}
			rv+="</pre>... means that a packet ";
			if (ether_type)
				rv+="type of <"+html_tag+">"+ether_type+"</"+html_tag+"> ";
			rv+="has arrived ";
			if (device)
				rv+="on the inbound interface <"+html_tag+">"+device+"</"+html_tag+"> ";
			rv+="from network host <"+html_tag+">"+source+"</"+html_tag+"> ";
			rv+="destined to <"+html_tag+">"+destination+"</"+html_tag+"> ";
			rv+="but it's coming from an <i>IP address/interface combination</i> that the kernel didn't expect. ";
			rv+="(The kernel would expect packet coming from "+source_values.groups.source_ip+" on an interface different than "+device+". Please revisit the routing table on the host logging the martian messages and/or fix the IP address of the source host.)";
		} else if(destination_values=s.match(RegExp(/martian destination (?<destination_ip>[0-9\.]+) from (?<source_ip>[0-9\.]+), (?:on )?dev (?<dev_in>\S+)/))) {
			rv+="The log item ...<br><pre>"+destination_values.input;
			rv+="</pre>... means that a packet ";
			rv+="has arrived ";
			if (destination_values.groups.dev_in)
				rv+="on the inbound interface <"+html_tag+">"+destination_values.groups.dev_in+"</"+html_tag+"> ";
			rv+="from network host <"+html_tag+">"+destination_values.groups.source_ip+"</"+html_tag+"> ";
			rv+="destined to the invalid IP address of <"+html_tag+">"+destination_values.groups.destination_ip+"</"+html_tag+"> ";
			rv+="that can not be routed. ";
			rv+="(According the Internet standards, the routing of the packet to the destination IP address "+destination_values.groups.destination_ip+" is not possible. Please revisit the applications running on the source host "+destination_values.groups.source_in+" to avoid sending traffic to void destinations.)";
		}
		if (rv.length)
			retval.push("<p>"+rv+"<p>");
	}
	document.getElementById(dst_dom_id).innerHTML=retval.join("\n");
	return 1;
}

