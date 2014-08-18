/* Stolen from: https://gist.github.com/1409855/ */
/* Original source code courtesy John from iOSDeveloperTips.com */

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

NSString* getMacAddress()
{
	//NSLog(@"%@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]);
	return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
	
    NSString    *macAddressString = NULL;
    int         mgmtInfoBase[6];
    char        *msgBuffer = NULL;
    size_t      length = 0;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;              
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0) 
        NSLog(@"if_nametoindex failure");
    // Get the size of the data available (store in len)
    else if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0) 
        NSLog(@"sysctl mgmtInfoBase failure");
    // Alloc memory based on above call
    else if ((msgBuffer = malloc(length)) == NULL)
        NSLog(@"buffer allocation failure");
    // Get system information, store in buffer
    else if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
    {
        free(msgBuffer);
        NSLog(@"sysctl msgBuffer failure");
    }
    else
    {
        // Map msgbuffer to interface message structure
        struct if_msghdr *interfaceMsgStruct = (struct if_msghdr *) msgBuffer;

        // Map to link-level socket structure
        struct sockaddr_dl *socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);

        // Copy link layer address data in socket structure to an array
        unsigned char macAddress[6];
        memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);

        // Read from char array into a string object, into traditional Mac address format
        macAddressString = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X",
							macAddress[0], macAddress[1], macAddress[2],
							macAddress[3], macAddress[4], macAddress[5]];

        // Release the buffer memory
        free(msgBuffer);
    }

    return macAddressString;
}

char f(int n)
{
    return "0123456789ABCDEF"[n];
}

NSString* getDateTimeValue()
{
    NSUInteger sec = [[NSDate date] timeIntervalSince1970];
	sec = sec % 15552000;
    char hex[20]="";
    int i = 0;
    
    while (sec) {
        hex[i++]=f(sec%16);
        sec/=16;
    }
    
    return [NSString stringWithFormat:@"%s", hex];
}

NSString* getMilliTimeValue()
{
	NSString* strTime = [NSString stringWithFormat:@"%0.0f", [[NSDate date] timeIntervalSince1970] * 1000];
	return strTime;
}
