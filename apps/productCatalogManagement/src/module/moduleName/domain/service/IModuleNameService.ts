
export interface IModuleNameService {
    findOne: (id: string) => Promise<any | null>;
}
