
const dirNames = [
    "constants",
    "controller",
    "controller/http",
    "domain",
    "domain/repository",
    "domain/service",
    "infrastructure",
]
let emptyClosuer = {|moduleName|
    
}

let genConstants  = {|moduleName|
print $moduleName
    touch ($moduleName | get path | path join "Enum.ts")
}

let genControllers = {|moduleName|
    
    touch ($moduleName | get path | path join "DTO.ts")
}

let genControllersHttp = {|moduleName|
    
    let httpPath = $moduleName | get path | path join "API.ts"
    touch $httpPath

    let ppath = ($moduleName | get path)
    let moduleName = ($moduleName | get moduleName)
    let serviceName = (echo "I" | append ((UpperCase $moduleName)) | append "Service" | str join '') 
    let serviceNameLow = (echo  $moduleName | append "Service" | str join '')
    let code = "
import InjectionToken from '../../../../InjectionToken'
import { GlobalExceptionFilter, TMFStandardException } from '@lotusflare/exceptions';
import { RequestLoggingInterceptor } from '@lotusflare/interceptor';
import { ApplicationConsoleLogger } from '@lotusflare/logger';
import { Body, Controller, Get, HttpStatus, Inject, Param, Post, Res, UseFilters, UseInterceptors, UsePipes, ValidationPipe } from '@nestjs/common';
import { ApiExcludeController } from '@nestjs/swagger';
import { " | append $serviceName | append " } from '../../domain/service/" | append $serviceName | append "';
import { Response } from 'express';
    
@UseFilters(new GlobalExceptionFilter(new ApplicationConsoleLogger(GlobalExceptionFilter.name)))
@UsePipes(new ValidationPipe({ exceptionFactory: TMFStandardException.createWith }))
@UseInterceptors(RequestLoggingInterceptor)
@ApiExcludeController()
@Controller('" | append $moduleName | append "/v1')
export class " | append (UpperCase  $moduleName) | append "Controller {
    constructor(@Inject(InjectionToken." | append $serviceNameLow | append ") private " | append $serviceNameLow | append ": " | append $serviceName |append ") {}

    @Get(':id')
    findOne(@Param('id') id: string) {
        return this." | append $serviceNameLow | append ".findOne(id);
    }
}  
    " | str join ''

    echo $code | save -f $httpPath

}

let genDomain = {|moduleName|
    
}


let genDomainService = {|moduleName|
    let ppath = ($moduleName | get path)
    let moduleName = ($moduleName | get moduleName)
    let servicePath = ($ppath | path join (echo (UpperCase $moduleName)| append "Service.ts" | str join '' ))
    touch $servicePath
    let iServicePath = $ppath | path join (echo "I" | append (UpperCase $moduleName)| append "Service.ts" | str join '')
    touch $iServicePath


    let serviceName = (echo "I" | append ((UpperCase $moduleName)) | append "Service" | str join '') 
    let serviceNameLow = (echo  $moduleName | append "Service" | str join '')
    let serviceNameUpper = (echo  (UpperCase $moduleName) | append "Service" | str join '')


    let serviceNameRepository = (echo "I" | append ((UpperCase $moduleName)) | append "Repository" | str join '') 
    let serviceNameLowRepository = (echo  $moduleName | append "Repository" | str join '')


    let serviceNameDao = (echo "I" | append ((UpperCase $moduleName)) | append "DAO" | str join '') 
    let serviceNameLowDao = (echo  $moduleName | append "DAO" | str join '')
    let code = "
export interface " | append $serviceName | append " {
    findOne: (id: string) => Promise<any | null>;
}
" | str join ''

    echo $code | save -f $iServicePath

    let codeImpl = "
import InjectionToken from '../../../../InjectionToken'
import { Injectable, Inject } from '@nestjs/common';
import { " | append $serviceNameRepository | append " } from '../repository/" | append $serviceNameRepository | append "';
import { " | append $serviceName | append " } from './" | append $serviceName | append "';

@Injectable()
export class " | append $serviceNameUpper | append " implements " | append $serviceName | append " {
    constructor(
        @Inject(InjectionToken." | append $serviceNameLowDao | append ") private " | append $serviceNameLowDao | append ": " | append $serviceNameRepository | append ",
    ) {

    }

    async findOne(id: string): Promise<any | null> {
        return this." | append $serviceNameLowDao | append ".findOne(id);
    }
}" | str join ''

    echo $codeImpl | save -f $servicePath
}

let genDomainRepository = {|moduleName|
    
    let ppath = ($moduleName | get path)
    let moduleName = ($moduleName | get moduleName)
    let iRepository = ($ppath | path join (echo "I" | append (UpperCase $moduleName)| append "Repository.ts" | str join ''))
    touch $iRepository


    let serviceNameRepository = (echo "I" | append ((UpperCase $moduleName)) | append "Repository" | str join '') 
    let serviceNameLowRepository = (echo  $moduleName | append "Repository" | str join '')

let code = "
export interface " | append $serviceNameRepository | append " {
    findOne: (id: string) => Promise<any | null>;
}
" | str join ''
    echo $code | save -f $iRepository
}


let genInfrastructures =  {|moduleName|
    
    
    let ppath = ($moduleName | get path)
    let moduleName = ($moduleName | get moduleName)
    let daoPath = ($ppath | path join (echo  (UpperCase $moduleName)| append "DAO.ts" | str join ''))
    touch $daoPath


    let serviceNameRepository = (echo "I" | append ((UpperCase $moduleName)) | append "Repository" | str join '') 
    let serviceNameLowRepository = (echo  $moduleName | append "Repository" | str join '')


    let serviceNameDao = (echo "I" | append ((UpperCase $moduleName)) | append "DAO" | str join '') 
    let serviceNameLowDao = (echo  $moduleName | append "DAO" | str join '')
    let serviceNameUpperDao = (echo  (UpperCase $moduleName) | append "DAO" | str join '')

let code = "
import { contentTypeKey, jsonContentTypeValue } from '@lotusflare/libs/constants/src/HttpHeaders';
import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { " | append $serviceNameRepository | append " } from '../domain/repository/" | append $serviceNameRepository | append "';
import { firstValueFrom } from 'rxjs';

import { petalUrl } from './Utils';

@Injectable()
export class " | append $serviceNameUpperDao | append " implements " | append $serviceNameRepository | append " {
    constructor(private httpService: HttpService) { }

    findOne = async (id: string): Promise<any | null> => {
        return ""
    }
}
" | str join ''
    
        echo $code | save -f $daoPath


        # utils
        let utilsPath = ($ppath | path join "Utils.ts")
        touch $utilsPath
        let codeUtils = "
import config from '../../../../config'

export const petalUrl = `${config.petalUrl}/" | append $moduleName | append "/v5`;
        " | str join ''

        echo $codeUtils | save -f $utilsPath

}


let genModuleFile  = {|moduleName|

let ppath = ($moduleName | get path)
let moduleName = ($moduleName | get moduleName)

let moduleClassName = (echo ((UpperCase $moduleName)) | append "Module" | str join '') 
let controllerName = (echo ((UpperCase $moduleName)) | append "Controller" | str join '') 

let serviceNameLow = (echo  $moduleName | append "Service" | str join '')
let serviceNameUpper = (echo  (UpperCase $moduleName) | append "Service" | str join '')

let serviceNameLowRepository = (echo  $moduleName | append "Repository" | str join '')
let serviceNameUpperRepository = (echo   (UpperCase $moduleName) | append "Repository" | str join '')

let serviceNameLowDao = (echo  $moduleName | append "DAO" | str join '')
let serviceNameUpperDao = (echo   (UpperCase $moduleName) | append "DAO" | str join '')

let code = "

import InjectionToken from '../../InjectionToken'
import { LoggerModule } from '@lotusflare/logger/logger.module';
import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { " | append $controllerName | append " } from './controller/http/API';
import { " | append $serviceNameUpper | append " } from './domain/service/" | append $serviceNameUpper | append "';
import { " | append $serviceNameUpperDao | append " } from './infrastructure/" | append $serviceNameUpperDao | append "';

@Module({
    imports: [LoggerModule, HttpModule],
    controllers: [" | append $controllerName | append "],
    providers: [
        " | append $serviceNameUpper | append ",
        {
            provide: InjectionToken." | append $serviceNameLowDao | append ",
            useClass: " | append $serviceNameUpperDao | append ",
        },
        {
            provide: InjectionToken." | append $serviceNameLow | append ",
            useClass: " | append $serviceNameUpper | append ",
        },
    ],
})
export class " | append $moduleClassName | append " { }
" | str join ''

    echo $code | save -f (echo $ppath | path join "Module.ts" )

}

let needAdd = {|moduleName|
let moduleName = ($moduleName | get moduleName)

let serviceNameLow = (echo  $moduleName | append "Service" | str join '')
let serviceNameLowDao = (echo  $moduleName | append "DAO" | str join '')
let code = "
    Conguratulation!!!  you have created a new sub module.

    *** you need added above code to  InjectToken.ts file: ***
    
    " | append $serviceNameLow | append " : '" | append $serviceNameLow | append "',
    " | append $serviceNameLowDao | append " : '" | append $serviceNameLowDao | append "'

    *** and remember to add your module to MainModule.ts file: ***
    

    @Module({
      imports: [
          HttpModule,
          HealthModule,
          LoggerModule,
          ....
          ....
          ....
          ....
         " | append (UpperCase $moduleName) | append "Module
      ]
})
"  | str join ''

print $code
}

def "main gen" [inputPath,moduleName] {
    
    let currentPath = $inputPath
    if $inputPath == "" {
        print "Please input your Module path, eg: apps/productCatalogManagement/src/module"
        exit 0
    }
    echo  $dirNames | each {|k| 
        let ppath = (echo $currentPath | path join $moduleName | path join $k)
        let data = {moduleName: $moduleName,path: $ppath}
        mkdir $ppath
        match $k {
            "constants" => { do $genConstants $data}
            "controller" => { do $genControllers $data}
            "controller/http" => { do $genControllersHttp $data}
            "domain" => { do $genDomain $data}
            "domain/repository" => { do $genDomainRepository $data}
            "domain/service" => { do $genDomainService $data}
            "infrastructure" => { do $genInfrastructures $data}
        }
    }

    do $genModuleFile {moduleName: $moduleName,path: (echo $currentPath | path join $moduleName )}
    do $needAdd {moduleName: $moduleName}
}



def "main up" [moduleName] {
    
    UpperCase $moduleName
}

def UpperCase [words] {
    let ws = echo $words | split chars
    let result = $ws| get 0 | str upcase | append ($ws | skip 1 | str join '') | str join ''
    return $result
}

# https://www.nushell.sh/book/scripts.html#subcommands
def main [] {}

