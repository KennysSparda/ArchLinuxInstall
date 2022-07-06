# ArchLinuxInstall
My script for install Arch linux more faster and do not forget anything :v

0 _ Você deve clonar este repositorio na maquina que deseja instalar o novo sistema
    e prossiga realizando o particionamento do disco utilizando: fdisk ou cfdisk.
    deixando obrigatoriamente: uma partição para o *boot (Min:300mb)
                           e uma partição para a *raiz "/" (Min:5gb)
                           
    referência: você vai ver aparecer recorrentemente o endereço: "/dev/sdXn"
            tenha em mente que no ato da instalação deve se substituir o
            "X" pela letra do dispositivo e o "n" pelo numero da partição
            ex: "/dev/sda2", "/dev/sdb1", "/dev/sdc4", etc.
            
1 _ Após formate as partições sendo:  *boot:      FAT32:  "mkfs.fat -f32 /dev/sdXn"
                                      *raiz "/":  ext4:   "mkfs.ext4 /dev/sdXn"

2 _ Monte a raiz em /mnt usando: "mount /dev/sdXn /mnt"
    crie uma pasta para o boot: "mkdir /mnt/boot" (se for utilizar UEFI criar 
    também pasta 'efi': "mkdir /mnt/boot/efi")

3 _ Realizado os procedimentos acima agora é hora de rodar o script utilizando:

    3_1:  Essa primeira etapa ira instalar as dependências nessessárias como:
    base do linux, driver de rede, ativa a funcionalidade para download em
    paralelo para acelerar a instalação e gera o importantíssimo arquivo
    "/etc/fstab" com os pontos de montagens salvos.
    
    "bash PreInstall.sh"
    
    3_2:  Importante ficar atento quando o script terminar pois lhe deixará dentro do
    sistema instalado para configurá-lo essa segunda etapa instala o inicializador do
    sistema "GRUB" além de drivers de video e habilitar por padrao coisas como driver
    de rede além de definir senha para o usuário root e criação de outros usuários.
    criará também arquivos de configuração para linguagem escolhida e layout do
    teclado. 
    
    "bash PosInstall.sh"
    
4 _ Configuração opcional para ativar o "clickOnTap" em notebooks, rodando como root:
    bash TapToClick.sh
