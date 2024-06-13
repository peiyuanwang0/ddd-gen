
import InjectionToken from '../../../../InjectionToken'
import { GlobalExceptionFilter, TMFStandardException } from '@lotusflare/exceptions';
import { RequestLoggingInterceptor } from '@lotusflare/interceptor';
import { ApplicationConsoleLogger } from '@lotusflare/logger';
import { Body, Controller, Get, HttpStatus, Inject, Param, Post, Res, UseFilters, UseInterceptors, UsePipes, ValidationPipe } from '@nestjs/common';
import { ApiExcludeController } from '@nestjs/swagger';
import { IModuleNameService } from '../../domain/service/IModuleNameService';
import { Response } from 'express';
    
@UseFilters(new GlobalExceptionFilter(new ApplicationConsoleLogger(GlobalExceptionFilter.name)))
@UsePipes(new ValidationPipe({ exceptionFactory: TMFStandardException.createWith }))
@UseInterceptors(RequestLoggingInterceptor)
@ApiExcludeController()
@Controller('moduleNameManagement/v1')
export class ModuleNameManagementController {
    constructor(@Inject(InjectionToken.moduleNameService) private moduleNameService: IModuleNameService) {}

    @Get(':id')
    findOne(@Param('id') id: string) {
        return this.moduleNameService.findOne(+id);
    }
}  
    