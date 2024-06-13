

import InjectionToken from '../../InjectionToken'
import { LoggerModule } from '@lotusflare/logger/logger.module';
import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { ModuleNameController } from './controller/http/API';
import { ModuleNameService } from './domain/service/ModuleNameService';
import { ModuleNameDAO } from './infrastructure/ModuleNameDAO';

@Module({
    imports: [LoggerModule, HttpModule],
    controllers: [ModuleNameController],
    providers: [
        ModuleNameService,
        {
            provide: InjectionToken.moduleNameDAO,
            useClass: ModuleNameDAO,
        },
        {
            provide: InjectionToken.moduleNameDAO,
            useClass: ModuleNameService,
        },
    ],
})
export class ModuleNameModule { }
