
import { contentTypeKey, jsonContentTypeValue } from '@lotusflare/libs/constants/src/HttpHeaders';
import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { IModuleNameRepository } from '../domain/repository/IModuleNameRepository';
import { firstValueFrom } from 'rxjs';

import { petalUrl } from './Utils';

@Injectable()
export class ModuleNameDAO implements IModuleNameRepository {
    constructor(private httpService: HttpService) { }

    findOne = async (id: string): Promise<any | null> => {
        return ""
    }
}
