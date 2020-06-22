var filter = "win16|win32|win64|mac|macintel"; 
	if ( navigator.platform ) { 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) { 
			console.log('mobile 접속'); 
		} else { 
			console.log("pc접속");
		} 
	}