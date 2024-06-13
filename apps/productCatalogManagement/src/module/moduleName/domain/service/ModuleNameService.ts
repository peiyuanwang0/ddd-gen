
import InjectionToken from '../../../../InjectionToken'
import { Injectable, Inject } from '@nestjs/common';
import { IModuleNameRepository } from '../repository/IModuleNameRepository';
import { IModuleNameService } from './IModuleNameService';

@Injectable()
export class ModuleNameService implements IModuleNameService {
    constructor(
        @Inject(InjectionToken.moduleNameDAO) private moduleNameDAO: IModuleNameRepository,
    ) {

    }

    async findOne(id: string): Promise<any | null> {
        return this.moduleNameDAO.findOne(+id);
    }
}