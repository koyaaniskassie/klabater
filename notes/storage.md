# Volumes
It's a directory for a pod. It can be ephemeral or with Persistent Volume it can live outside of pod's lifecycle

## Types of Volumes
noting now those worthy of mention

- configMap - insert contents to given hostPath
- secret - same thing as configMap BUT:
  - A Secret is always mounted as `readOnly`
  - A container using Secret as a `subPath` volume mount will not receive Secret updates
- emptyDir - create volume that's empty for future use by pods. It dies with the pod it was mounted to 
- hostPath - dangerous- access hosts filesystem. If you need access to e.g. logs of the node itself then use it
- image - not sure of a usecase yet
- local - represents a mounted local storage device- disk, partition or directory. Better `hostPath` uses local space. MUST set `nodeAffinity` for resource `PersistentVolume`
- iscsi - uses iscsi to create volumes. You MUST set up iSCSI server first to use it. Kubernetes does not do that

These are built-in types (and not all of them) for the rest you have to define CSI- Container Storage Interface. With this you can use Amazon EBS or Azure Disck Container Storage Interface

For now I'll use `local` storage- it requires least amount of configuration for reasonable outcome

## StorageClass


# Configuring `local` storage
## StorageClass

```
